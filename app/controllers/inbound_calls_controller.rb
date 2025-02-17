class InboundCallsController < ApplicationController
  # Disable CSRF protection for webhook calls
  skip_before_action :verify_authenticity_token

  # Stores an inbound Call's details when a webhook from Vonage is received
  def create
    Call.where(conversation_uuid: params[:conversation_uuid])
        .first_or_create
        .update(
          to: params[:to],
          from: params[:from]
        )

    # Return a message to play back to the caller
    render json: [
      {
        action: 'talk',
        "language": "en-GB",
        "style": 1,
        text: 'Hello, thank you for calling. This is Jennifer from Vonage. How can we help you today?'
      }
    ]
  end
end
