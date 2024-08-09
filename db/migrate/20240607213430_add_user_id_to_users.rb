# db/migrate/20240607213430_add_user_id_to_users.rb
class AddUserIdToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :id, :primary_key
    add_column: :users, :user_id
    execute "ALTER TABLE users ADD PRIMARY KEY (user_id);"
  end
end
