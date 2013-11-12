class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn10, :isbn13 :asin,
  :amazon_ref, :amazon_img, :img_height, :img_width, :price,
  :description, :publisher

  has_many :users, through :book_user
  has_many :lists, through :best_seller_list_book

end
