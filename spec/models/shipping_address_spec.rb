require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    @shipping_address = FactoryBot.build(:shipping_address)
  end

  describe '商品購入' do
    context '購入できる場合' do
      it "入力情報に不備がなければ購入できる" do
        expect(@shipping_address).to be_valid
      end
    end

    context '購入できない場合' do
      it "postal_codeが空では購入できない" do
        @shipping_address.postal_code = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it "postal_codeに「-」が含まれていないと保存できない" do
        @shipping_address.postal_code = '1234567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code must be in the format 123-4567")
      end
      it "prefecture_idが「---」では出品できない" do
        @shipping_address.prefecture_id = 1
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Prefecture must be other than 「---」")
      end
      it "cityが空では購入できない" do
        @shipping_address.city = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it "phone_numberが空では購入できない" do
        @shipping_address.phone_number = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberに「-」が含まれていると購入できない" do
        @shipping_address.phone_number = '080-1111-1111'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number must be 10–11 digits long and contain no hyphens")
      end
      it "phone_numberが9桁以下だと購入できない" do
        @shipping_address.phone_number = '088535159'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number must be 10–11 digits long and contain no hyphens")
      end
      it "phone_numberが11桁以上だと購入できない" do
        @shipping_address.phone_number = '080111111111'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number must be 10–11 digits long and contain no hyphens")
      end
    end
  end
end


