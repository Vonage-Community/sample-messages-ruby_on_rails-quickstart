class OutboundSmsController < ApplicationController
  def new
    @sms_message = SmsMessage.new
  end

  def create
    # Create a SMS record to be stored in the database
    @sms_message = SmsMessage.new(safe_params)

    if @sms_message.save
      deliver @sms_message
      redirect_to :new_outbound_sms, notice: 'SMS Sent'
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  private

  def safe_params
    params.require(:sms_message).permit(:to, :from, :text)
  end

  def vonage
    Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )
  end

  def deliver(sms_message)
    message = vonage.messaging.sms(message: sms_message.text)

    response = vonage.messaging.send(
      from: sms_message.from,
      to: sms_message.to,
      **message
    )

    if response.http_response.code == '202'
      sms_message.update(
        message_uuid: response.entity.attributes[:message_uuid]
      )
    end
  end
end
