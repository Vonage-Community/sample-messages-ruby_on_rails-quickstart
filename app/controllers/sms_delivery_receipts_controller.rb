class SmsDeliveryReceiptsController < ApplicationController
  # We disable CSRF for this webhook call
  skip_before_action :verify_authenticity_token

  # Updates an SMS message's status when a valid
  # delivery receipt has been received
  def create
    # Find the SMS for the Message ID, and update it with the
    # status, only if the Message ID was provided
    Sms.where(message_uuid: params[:sms_delivery_receipt][:message_uuid])
       .update_all(status: params[:sms_delivery_receipt][:status]) if params[:sms_delivery_receipt][:message_uuid]

    # Return an empty HTTP 200 status
    head :ok
  end
end