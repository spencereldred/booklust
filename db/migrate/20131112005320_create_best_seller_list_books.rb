class CreateBestSellerListBooks < ActiveRecord::Migration
  def change
    create_table :best_seller_list_books do |t|
      t.integer :book_id
      t.integer :best_seller_list_id
      t.integer :rank
      t.integer :number_weeks

      t.timestamps
    end
  end
end
