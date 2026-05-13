require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品が出来る場合' do
      it "name,description,category_id,status_id,shipping_fee_id,prefecture_id,delivery_time_id,priceが存在すれば出品できる" do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it "nameが空では出品できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "descriptionが空では出品できない" do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "category_idが「---」では出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 「---」")
      end
      it "status_idが「---」では出品できない" do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 「---」")
      end
      it "shipping_fee_idが「---」では出品できない" do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee must be other than 「---」")
      end
      it "prefecture_idが「---」では出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 「---」")
      end
      it "delivery_time_idが「---」では出品できない" do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time must be other than 「---」")
      end
      it "priceが空では出品できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが300円未満では出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be between 300 and 9,999,999")
      end
      it "priceが9999999円以上では出品できない" do
        @item.price = 9999999999
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be between 300 and 9,999,999")
      end
      it "priceが半角数字以外のものが含まれていたら出品できない" do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be between 300 and 9,999,999")
      end
      it "imageが空では出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "userが紐づいていなければ出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
