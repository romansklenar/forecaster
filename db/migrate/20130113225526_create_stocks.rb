class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :company, index: true
      t.date :date
      t.decimal :open,  precision: 9, scale: 2
      t.decimal :high,  precision: 9, scale: 2
      t.decimal :low,   precision: 9, scale: 2
      t.decimal :close, precision: 9, scale: 2
      
      t.timestamps
    end
  end
end
