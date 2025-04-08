class CreateCalls < ActiveRecord::Migration[8.0]
  def change
    create_table :calls do |t|
      t.string :to
      t.string :from
      t.text :text
      t.string :uuid
      t.string :status
      t.boolean :is_inboud
      t.string :conversation_uuid

      t.timestamps
    end
  end
end
