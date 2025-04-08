class RenameIsInboudToIsInbound < ActiveRecord::Migration[8.0]
  def change
    rename_column :calls, :is_inboud, :is_inbound
  end
end
