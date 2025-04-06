class CreateSmsMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :sms_messages do |t|
      t.string :to
      t.string :from
      t.text :text
      t.string :status
      t.string :message_uuid
      t.boolean :is_inbound

      t.timestamps
    end
  end
end
