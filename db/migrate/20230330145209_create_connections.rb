class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.integer :frog_1
      t.integer :frog2
      t.integer :family_members_id

      t.timestamps
    end
  end
end
