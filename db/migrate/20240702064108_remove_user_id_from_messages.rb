class RemoveUserIdFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :user_id, :integer
  end
end
