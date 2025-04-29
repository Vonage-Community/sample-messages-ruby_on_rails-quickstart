class OutboundRcsController < ApplicationController
  def new
    @rcs_message = RcsMessage.new
  end

  def create
    @rcs_message = RcsMessage.new(to: safe_params[:to], from: ENV["RCS_SENDER_ID"], message_type: 'custom')
    custom_message = construct_custom_message(params[:rcs_message])
    @rcs_message.custom = custom_message

    if @rcs_message.save
      deliver @rcs_message
      redirect_to :new_outbound_rcs, flash: { notice: 'RCS Sent' }
    else
      flash[:alert] = 'Something went wrong'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:rcs_message).permit(:to)
  end

  def construct_custom_message(rcs_message_params)
    content_message = rcs_message_params[:contentMessage]
    suggestions = rcs_message_params[:suggestions]
    {
      contentMessage: {
        text: content_message,
        suggestions: Array(suggestions).reject(&:blank?).each_with_index.map do |suggestion, idx|
          {
            reply: {
              text: suggestion,
              postbackData: "value#{idx + 1}"
            }
          }
        end
      }
    }
  end

  def vonage 
    Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )
  end

  def deliver(rcs_message)
    message = vonage.messaging.rcs(
      type: rcs_message.message_type,
      message: rcs_message.custom
    )

    response = vonage.messaging.send(
      from: ENV["RCS_SENDER_ID"],
      to: rcs_message.to,
      **message
    )

    puts response

    if response.http_response.code == '202'
      rcs_message.update(
        message_uuid: response.entity.attributes[:message_uuid]
      )
    end
  end
end
