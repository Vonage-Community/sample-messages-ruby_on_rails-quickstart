class RcsMessageStatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
   RcsMessage.where(message_uuid: params[:rcs_message_status][:message_uuid])
       .update_all(status: params[:rcs_message_status][:status]) if params[:rcs_message_status][:message_uuid]

    # Return an empty HTTP 200 status
    head :ok
  end
end
