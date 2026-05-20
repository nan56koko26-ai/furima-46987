require 'rails_helper'

describe Purchase, type: :model do

  before do
    @purchase = FactoryBot.build(:purchase)
  end

  context '内容に問題ない場合' do
    it "userとitem,tokenがあれば保存ができること" do
      expect(@purchase).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "userが含まれていないと保存できない" do
      @purchase.user = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("User must exist")
    end

    it "itemが含まれていないと保存できない" do
      @purchase.item = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Item must exist")
    end

    it "tokenが空では登録できないこと" do
      @purchase.token = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Token can't be blank")
    end
  end
end


