class OutboundWhatsappController < ApplicationController
  def new
    @whatsapp_message = WhatsappMessage.new
  end

  def create
    @whatsapp_message = WhatsappMessage.new(safe_params)

    if @whatsapp_message.save
      deliver(@whatsapp_message)
      redirect_to :new_outbound_whatsapp, notice: 'WhatsApp message sent!'
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  def interactive
    unless params[:to].present?
      redirect_to :new_outbound_whatsapp, alert: "Recipient number is required!"
      return
    end

    interactive_message = {
      from: ENV["VONAGE_WHATSAPP_NUMBER"],
      to: params[:to],
      channel: "whatsapp",
      message_type: "custom",
      custom: {
        type: "interactive",
        interactive: {
          type: "button",
          header: {
            type: "text",
            text: "Delivery time"
          },
          body: {
            text: "Which time would you like us to deliver your order at?"
          },
          footer: {
            text: "Please allow 15 minutes either side of your chosen time."
          },
          action: {
            buttons: [
              {
                type: "reply",
                reply: { id: "slot-1", title: "15:00" }
              },
              {
                type: "reply",
                reply: { id: "slot-2", title: "16:30" }
              },
              {
                type: "reply",
                reply: { id: "slot-3", title: "17:15" }
              }
            ]
          }
        }
      }
    }

    response = vonage.messaging.send(**interactive_message)
    Rails.logger.info("📤 Sent interactive message to #{params[:to]}: #{response.inspect}")

    redirect_to :new_outbound_whatsapp, notice: "Interactive message sent to #{params[:to]}!"
  end

  private

  def safe_params
    params.require(:whatsapp_message).permit(:to, :from, :text)
  end

  def vonage
    Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )
  end

  def deliver(whatsapp_message)
    response = vonage.messaging.send(
      message_type: "text",
      text: whatsapp_message.text,
      to: whatsapp_message.to,
      from: whatsapp_message.from,
      channel: "whatsapp"
    )

    if response.http_response.code == "202"
      whatsapp_message.update(
        message_uuid: response.entity.attributes[:message_uuid]
      )
    end
  end
end
