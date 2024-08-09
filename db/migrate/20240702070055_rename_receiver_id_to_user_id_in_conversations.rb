class RenameReceiverIdToUserIdInConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      rename_column :conversations, :receiver_id, :user_id
    end
  end
end
