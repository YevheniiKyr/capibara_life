class CreateCapibaras < ActiveRecord::Migration[7.0]
  def change
    create_table :capibaras do |t|
      t.string :image
      t.string :description
      t.float :age,  default: 0
      t.float :weight,  default: 10
      t.integer :money,  default: 100
      t.integer :power, default:100
      t.string :name
      t.timestamps
    end
  end
end
