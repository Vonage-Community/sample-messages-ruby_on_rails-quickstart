# app/controllers/inbound_sms_controller.rb

class InboundSmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create

    sms_message = SmsMessage.create(
      to: params[:to],
      from: params[:from],
      text: params[:text],
      message_uuid: params[:message_uuid],
      is_inbound: true
    )

    # Send a reply
    reply(sms_message)

    # Return an empty HTTP 200 status regardless
    head :ok
  end

  private

  def vonage
    Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )
  end

  def reply(sms_message)
    consonants = sms_message.text.delete("aeiouAEIOU")
    binary = sms_message.text.unpack1('B*')

    message = vonage.messaging.sms(message: "Your message without vowels is #{consonants} and your message in binary is #{binary}")

    vonage.messaging.send(
      from: sms_message.to,
      to: sms_message.from,
      **message
    )
  end
end
