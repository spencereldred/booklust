class BestSellerList < ActiveRecord::Base
  attr_accessible :week, :category, :list_source

  has_many :books, through: :best_seller_list_book
end
