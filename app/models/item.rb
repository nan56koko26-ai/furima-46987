class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :purchases

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :delivery_time
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :status



  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :status_id, presence: true
  validates :status_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :shipping_fee_id, presence: true
  validates :shipping_fee_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :prefecture_id, presence: true
  validates :prefecture_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :delivery_time_id, presence: true
  validates :delivery_time_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "must be between 300 and 9,999,999" }
  validates :user, presence: true 
  validates :image, presence: true


end
