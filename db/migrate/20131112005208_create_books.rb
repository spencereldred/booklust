class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn10
      t.string :isbn13
      t.string :asin
      t.string :amazon_ref
      t.string :amazon_img
      t.string :img_height
      t.string :img_width
      t.string :price
      t.text   :description
      t.string :publisher

      t.timestamps
    end
  end
end
