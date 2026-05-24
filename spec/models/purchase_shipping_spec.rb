require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do

  before do
    @purchase_shipping = FactoryBot.build(:purchase_shipping)
  end

  describe '商品購入' do
    context '購入できる場合' do
      it "入力情報に不備がなければ購入できる" do
        expect(@purchase_shipping).to be_valid
      end
      it "建物名が空でも購入できる" do
        expect(@purchase_shipping).to be_valid
      end
    end

    context '購入できない場合' do
      it "userが含まれていないと保存できない" do
        @purchase_shipping.user = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("User must exist")
      end

      it "itemが含まれていないと保存できない" do
        @purchase_shipping.item = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Item must exist")
      end

      it "tokenが空では登録できないこと" do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
      it "postal_codeが空では購入できない" do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it "postal_codeに「-」が含まれていないと保存できない" do
        @purchase_shipping.postal_code = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code must be in the format 123-4567")
      end
      it "prefecture_idが「---」では出品できない" do
        @purchase_shipping.prefecture_id = 1
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Prefecture must be other than 「---」")
      end
      it "cityが空では購入できない" do
        @purchase_shipping.city = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("City can't be blank")
      end
      it "phone_numberが空では購入できない" do
        @purchase_shipping.phone_number = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberに「-」が含まれていると購入できない" do
        @purchase_shipping.phone_number = '080-1111-1111'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number must be 10–11 digits long and contain no hyphens")
      end
      it "addressが空では購入できない" do
        @purchase_shipping.address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberが9桁以下だと購入できない" do
        @purchase_shipping.phone_number = '088535159'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number must be 10–11 digits long and contain no hyphens")
      end
      it "phone_numberが12桁以上だと購入できない" do
        @purchase_shipping.phone_number = '080111111111'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number must be 10–11 digits long and contain no hyphens")
      end
    end
  end
end
