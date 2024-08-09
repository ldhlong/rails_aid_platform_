class AddJtiToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :jti
  end
end
