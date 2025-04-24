class OutboundRcsController < ApplicationController
  def new
    @rcs_message = RcsMessage.new
  end

  def create
    custom_message = construct_custom_message(params[:rcs_message][:contentMessage], params[:rcs_message][:suggestions])rcs
    @rcs_message = RcsMessage.new(to: safe_params[:to], from: ENV["RCS_SENDER_ID"], message_type: 'custom')
    @rcs_message.custom = custom_message

    if @rcs_message.save
      deliver @rcs_message
      redirect_to :new_outbound_rcs, flash[:notice] => 'RCS Sent'
    else

      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  private

  def construct_custom_message(contentMessage, suggestions)
    {
      contentMessage: {
        text: contentMessage,
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

  def safe_params
    params.require(:rcs_message).permit(:to, :contentMessage, :suggestions)
  end

  def deliver(rcs_message)

    vonage_client = Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )

    message = vonage_client.messaging.rcs(
      type: rcs_message.message_type,
      message: rcs_message.custom
    )

    vonage_client.messaging.send(
    from: 'RubyonRailsQuickstart',
    to: rcs_message.to,
    **message
  )

    puts "Messages API Response:"
    puts response
  end
  
end
