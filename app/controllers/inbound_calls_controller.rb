# app/controllers/inbound_calls_controller.rb
class InboundCallsController < ApplicationController
  # We disable CSRF for this webhook call
  skip_before_action :verify_authenticity_token

  def create
    Call.where(conversation_uuid: params[:conversation_uuid])
        .first_or_create
        .update(
          to: params[:to],
          from: params[:from],
          uuid: params[:uuid],
          conversation_uuid: params[:conversation_uuid],
          is_inbound: true

        )

    render json: [
      {
        action: 'talk',
        voiceName: 'Jennifer',
        text: 'Hello, thank you for calling. This is Jennifer from Vonage. Ciao.'
      }
    ]
  end
end
