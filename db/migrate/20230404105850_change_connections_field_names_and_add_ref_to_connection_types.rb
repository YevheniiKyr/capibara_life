class ChangeConnectionsFieldNamesAndAddRefToConnectionTypes < ActiveRecord::Migration[7.0]
  def change
    rename_column :connections, :frog2, :capi_2
    rename_column :connections, :frog_1, :capi_1
    remove_column :connections, :family_members_id
    add_reference :connections, :connection_type, null: false, foreign_key: true
    add_column :connections, :status, :string

  end
end
