class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  validates :user, presence: { message: "must exist" }
  validates :item, presence: { message: "must exist" }
  validates :token, presence: true
  attr_accessor :token

end
