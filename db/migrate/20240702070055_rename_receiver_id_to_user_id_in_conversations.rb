class RenameReceiverIdToUserIdInConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      add_column :conversations, :sender_id, :integer
      add_column :conversation, :user_id, :integer
    end
  end
end
