class OutboundSmsController < ApplicationController
  require 'vonage'

  # Shows the UI for sending an SMS
  def index
    @sms = Sms.new
  end

  # Sends an SMS
  def create
    # Create a SMS record to be stored in the database
    @sms = Sms.new(safe_params)

    if @sms.save
      deliver @sms
      redirect_to :outbound_sms, notice: 'SMS Sent'
    else
      flash[:alert] = 'Something went wrong'
      render :index
    end
  end

  private

  # Initializes the Vonage API client
  def vonage
    # Initialize the Vonage client with API credentials and token
    Vonage::Client.new(
      api_key: ENV["VONAGE_API_KEY"], 
      api_secret: ENV["VONAGE_API_SECRET"], 
      token: generate_vonage_token
    )
  end

  # Generates a JWT token for Vonage API authentication
  def generate_vonage_token
    claims = {
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    }
    Vonage::JWT.generate(claims)
  end

  # Determines the params that can be
  # stored in the database safely
  def safe_params
    params.require(:sms).permit(:to, :from, :text)
  end

  # Uses the Vonage API to send the stored
  # SMS message
  def deliver sms
    message = Vonage::Messaging::Message.sms(message: sms.text)

    response = vonage.messaging.send(
      from: sms.from,
      to: sms.to,
      **message
    )

    # If sending the SMS was a success (HTTP 202)
    # then store the message UUID on the SMS record
    if response.http_response.code == '202'
      sms.update(
        message_uuid: response.entity.attributes[:message_uuid]
      )
    end
  end
end