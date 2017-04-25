class Item < ApplicationRecord
  has_many :ownerships
  has_many :users, through: :ownerships
  has_many :wants
  has_many :want_users, through: :wants, class_name: "User", source: :user

  has_many :item
  has_many :item_users, through: :item, class_name: "User", source: :user

  has_many :have
  has_many :have_users, through: :have, class_name: "User", source: :user
  
  validates :code, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
end
