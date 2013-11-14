class BestSellerListBook < ActiveRecord::Base
  attr_accessible :book_id, :best_seller_list_id, :rank, :number_weeks

  belongs_to :book
  belongs_to :best_seller_list

  validates_presence_of :book_id, :best_seller_list_id, :rank
end
