class CreateRcsMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :rcs_messages do |t|
      t.string :to
      t.string :from
      t.string :message_uuid
      t.string :timestamp
      t.string :message_type
      t.json :custom
      t.json :reply

      t.timestamps
    end
  end
end
