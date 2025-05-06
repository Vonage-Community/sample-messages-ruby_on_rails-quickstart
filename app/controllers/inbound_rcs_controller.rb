class InboundRcsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    rcs = RcsMessage.create(
      message_uuid: params[:message_uuid],
      from: params[:from],
      to: params[:to],
      timestamp: params[:timestamp],
      message_type: params[:message_type],
      reply: params[:reply]
    )
    reply(rcs)
    head :ok
  end

  private


  def vonage 
    Vonage::Client.new(
      application_id: ENV["VONAGE_APPLICATION_ID"],
      private_key: ENV["VONAGE_PRIVATE_KEY"]
    )
  end

  def reply(rcs)
    selection = rcs.reply["title"]
    message = vonage.messaging.rcs(
      type: "text",
      message: "#{selection} is a great choice!"
    )

    vonage.messaging.send(
      from: ENV["RCS_SENDER_ID"],
      to: rcs.from,
      **message
    )

  end
end
