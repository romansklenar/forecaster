class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :company, index: true
      t.string :title
      t.string :link
      t.datetime :date
      t.text :content_html
      t.text :content_text

      t.timestamps
    end
  end
end
