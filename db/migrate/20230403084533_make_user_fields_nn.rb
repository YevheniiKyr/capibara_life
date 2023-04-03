class MakeUserFieldsNn < ActiveRecord::Migration[7.0]
  def change
    User.where(name: nil).delete_all
    User.where(role: nil).delete_all
    User.where(password: nil).delete_all

    change_column :users, :name, :string, null: false
    change_column :users, :password, :string, null: false
    change_column :users, :role, :string, null: false

  end
end
