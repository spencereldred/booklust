class User < ActiveRecord::Base

  has_many :books, through: :book_user

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  validates_presence_of :name
  validates_presence_of :uid
  validates_presence_of :provider
end
