class PurchaseShipping


  include ActiveModel::Model
  attr_accessor :user, :item, :token, :postal_code, :building_name, :prefecture_id, :city, :address, :phone_number


  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format 123-4567" }
  validates :prefecture_id, presence: true
  validates :prefecture_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "must be 10–11 digits long and contain no hyphens" }
  validates :user, presence: { message: "must exist" }
  validates :item, presence: { message: "must exist" }
  validates :token, presence: true


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(token: token, purchase_id: purchase_id, postal_code: postal_code, prefecture: prefecture, city: city, address: address, phone_number: phone_number)
  end
end