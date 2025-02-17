class SmsDeliveryReceiptsController < ApplicationController
  # We disable CSRF for this webhook call
  skip_before_action :verify_authenticity_token

  # Updates an SMS message's status when a valid
  # delivery receipt has been received
  def create
    # Find the SMS for the Message ID, and update it with the
    # status, only if the Message ID was provided
    Sms.where(message_uuid: params[:message_uuid])
       .update_all(status: params[:status]) if params[:message_uuid]

    # Return an empty HTTP 200 status
    head :ok
  end
end