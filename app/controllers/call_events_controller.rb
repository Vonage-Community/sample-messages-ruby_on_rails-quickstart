# app/controllers/call_events_controller.rb
class CallEventsController < ApplicationController
  # We disable CSRF for this webhook call
  skip_before_action :verify_authenticity_token

  def create
    if params[:uuid]
      Call.where(uuid: params[:uuid])
          .first_or_create
          .update(
            status: params[:status],
            conversation_uuid: params[:conversation_uuid]
          )
    end

    head :ok
  end
end
