class RenameReceiverIdToUserIdInConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.integer "sender_id"
      t.integer "user_id"
    end
  end
end
