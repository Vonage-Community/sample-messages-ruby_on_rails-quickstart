class AddFieldsToSms < ActiveRecord::Migration[8.0]
  def change
    add_column :sms, :to, :string
    add_column :sms, :from, :string
    add_column :sms, :text, :text
    add_column :sms, :message_uuid, :string
    add_column :sms, :is_inbound, :boolean
    add_column :sms, :status, :string
  end
end
