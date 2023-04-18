class AddUserIdToCapibaras < ActiveRecord::Migration[7.0]
  def change
    add_reference :capibaras, :user, null: true, foreign_key: true
  end
end
