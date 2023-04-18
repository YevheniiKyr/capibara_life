class SetConnectionFieldToNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :connections, :capi_1, false
    change_column_null :connections, :capi_2, false
    change_column_null :connections, :connection_type_id, false

  end
end
