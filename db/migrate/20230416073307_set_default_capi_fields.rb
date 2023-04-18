class SetDefaultCapiFields < ActiveRecord::Migration[7.0]
  def change
    change_column_default :capibaras, :weight, 10
    change_column_default :capibaras, :money, 100
    change_column_default :capibaras, :power, 10
    change_column_default :capibaras, :age, 0
  end
end
