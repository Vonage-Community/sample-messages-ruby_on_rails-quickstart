class AddStatusToRcsMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :rcs_messages, :status, :string
  end
end
