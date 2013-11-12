class CreateBestSellerLists < ActiveRecord::Migration
  def change
    create_table :best_seller_lists do |t|
      t.string :week
      t.string :category
      t.string :list_source

      t.timestamps
    end
  end
end
