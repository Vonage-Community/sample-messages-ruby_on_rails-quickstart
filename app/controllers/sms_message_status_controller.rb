class SmsMessageStatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    SmsMessage.where(message_uuid: params[:sms_message_status][:message_uuid])
       .update_all(status: params[:sms_message_status][:status]) if params[:sms_message_status][:message_uuid]

    # Return an empty HTTP 200 status
    head :ok
  end
end
