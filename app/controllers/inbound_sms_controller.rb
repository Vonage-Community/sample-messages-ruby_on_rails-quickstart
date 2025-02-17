class InboundSmsController < ApplicationController
  require 'vonage'
  # We disable CSRF for this webhook call
  skip_before_action :verify_authenticity_token

  # Stores an inbound SMS when a webhook
  # from Vonage is received
  def create
    # Creates a new SMS record in
    # the database
    sms = Sms.create(
      to: params[:to],
      from: params[:from],
      text: params[:text],
      message_uuid: params[:message_uuid],
      # Seperate inbound SMS from outbound ones
      is_inbound: true
    )

    # Send a reply
    reply sms

    # Return an empty HTTP 200 status regardless
    head :ok
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


  # Uses the Vonage API to send a quick reply to the SMS received
  # for simplicity we're not storing this one in the database
  def reply sms
    message = Vonage::Messaging::Message.sms(message: sms.text.reverse)

    vonage.messaging.send(
      from: sms.to,
      to: sms.from,
      **message
    )
  end
end