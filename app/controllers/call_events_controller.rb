
class CallEventsController < ApplicationController
  # Disable CSRF protection for webhook calls
  skip_before_action :verify_authenticity_token

  # Updates a Call's status when an update event comes in
  def create
    if params[:uuid]
      Call.where(uuid: params[:uuid])
          .first_or_create
          .update(
            status: params[:status],
            conversation_uuid: params[:conversation_uuid],
            is_inbound: (params[:direction] == 'inbound')
          )
    end

    head :ok
  end
end
