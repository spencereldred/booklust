class BookUser < ActiveRecord::Base
  attr_accessible :user_id, :book_id, :vote, :purchased, :read, :star_rating, :bucket

  belongs_to :book
  belongs_to :user

  validates_presence_of :user_id, :book_id
end
