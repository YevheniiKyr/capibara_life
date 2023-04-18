class AddUniqueNameAndUserToCapi < ActiveRecord::Migration[7.0]
  def change

    execute <<-SQL
      DELETE FROM capibaras
      WHERE id NOT IN (
        SELECT MIN(id)
        FROM capibaras
        GROUP BY name
        HAVING COUNT(*) = 1
      )
    SQL

    # Delete duplicate Capybara records by user_id
    execute <<-SQL
      DELETE FROM capibaras
      WHERE id NOT IN (
        SELECT MIN(id)
        FROM capibaras
        GROUP BY user_id
        HAVING COUNT(*) = 1
      )
    SQL

    remove_index :capibaras, :user_id
    add_index :capibaras, :user_id, unique: true
    add_index :capibaras, :name, unique: true
  end
end
