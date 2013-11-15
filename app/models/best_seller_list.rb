class BestSellerList < ActiveRecord::Base
  attr_accessible :week, :category, :list_source

  has_many :best_seller_list_book
  has_many :books, through: :best_seller_list_book

  validates_presence_of :week, :category, :list_source
end
