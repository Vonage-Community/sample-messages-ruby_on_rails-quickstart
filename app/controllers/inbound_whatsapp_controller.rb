class InboundWhatsappController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @messages = WhatsappMessage.where(is_inbound: true).order(created_at: :desc)
  end

  def inbound
    payload = JSON.parse(request.body.read)
    Rails.logger.info("📥 Inbound message: #{payload}")

    from = payload["from"]
    to = payload["to"]
    message_uuid = payload["message_uuid"]
    message_type = payload["message_type"]
    profile_name = payload.dig("profile", "name")

    # Parse message based on type
    if message_type == "reply"
      # Interactive button reply
      reply_id = payload.dig("reply", "id")
      reply_title = payload.dig("reply", "title")
      text = "Selected: #{reply_title}"
      reply_data = payload["reply"].to_json
    elsif message_type == "text"
      # Regular text message
      text = payload["text"]
      reply_data = nil
    else
      # Fallback for other message types
      text = payload["text"] || "Unsupported message type: #{message_type}"
      reply_data = nil
    end

    WhatsappMessage.create!(
      from: from,
      to: to,
      text: text,
      message_uuid: message_uuid,
      message_type: message_type,
      profile_name: profile_name,
      reply_data: reply_data,
      is_inbound: true
    )

    head :ok
  end

  # Handle delivery and read status updates
  def status
    payload = JSON.parse(request.body.read)
    Rails.logger.info("📡 Status update: #{payload}")

    message_uuid = payload.dig("message_uuid")
    status = payload.dig("status")

    if message_uuid && status
      message = WhatsappMessage.find_by(message_uuid: message_uuid)
      message&.update(status: status)
    end

    head :ok
  end
end