class AddUniqueIndexToNameFieldOnConnectionTypes < ActiveRecord::Migration[7.0]
  def change
    add_index :connection_types, :name, unique: true
  end
end
