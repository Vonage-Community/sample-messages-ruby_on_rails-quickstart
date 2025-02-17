class CreateSms < ActiveRecord::Migration[8.0]
  def change
    create_table :sms do |t|
      t.timestamps
    end
  end
end
