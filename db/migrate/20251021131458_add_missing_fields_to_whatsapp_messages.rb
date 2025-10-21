class AddMissingFieldsToWhatsappMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :whatsapp_messages, :message_type, :string
    add_column :whatsapp_messages, :profile_name, :string
    add_column :whatsapp_messages, :reply_data, :text
  end
end
