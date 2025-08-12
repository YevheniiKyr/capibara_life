class RemoveIndexFromUsers < ActiveRecord::Migration[7.0]
  def change
    #remove_index :users, name: "index_users_on_username"
  end
end
