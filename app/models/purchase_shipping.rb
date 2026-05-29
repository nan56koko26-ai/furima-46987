class PurchaseShipping


  include ActiveModel::Model
  attr_accessor :user, :item, :token, :postal_code, :building_name, :prefecture_id, :city, :address, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format 123-4567" }
    validates :prefecture_id, numericality: { other_than: 1 , message: "must be other than 「---」"}
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "must be 10–11 digits long and contain no hyphens" }
    validates :token
  end

  validates :user, presence: { message: "must exist" }
  validates :item, presence: { message: "must exist" }
  


  def save
    purchase = Purchase.create(user_id: user.id, item_id: item.id)
    ShippingAddress.create(purchase_id: purchase.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, phone_number: phone_number)
  end
end