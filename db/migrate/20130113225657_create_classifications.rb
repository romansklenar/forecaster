class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.references :company, index: true
      t.text :text
      t.string :category

      t.timestamps
    end
  end
end
