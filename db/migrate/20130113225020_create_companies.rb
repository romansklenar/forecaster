class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :code
      t.string :messages_url
      t.string :stocks_url

      t.timestamps
    end
  end
end
