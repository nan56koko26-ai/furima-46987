class ShippingAddress < ApplicationRecord
  belongs_to :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format 123-4567" }
  validates :prefecture_id, presence: true
  validates :prefecture_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "must be 10–11 digits long and contain no hyphens" }
  

end
