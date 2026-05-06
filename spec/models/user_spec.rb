require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが英字のみのパスワードでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is not a mix of alphanumeric characters")
      end
      it 'passwordが数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is not a mix of alphanumeric characters")
      end
      it 'passwordが全角文字を含むパスワードでは登録できない' do
        @user.password = 'ｈabe123'
        @user.password_confirmation = 'ｈabc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is not a mix of alphanumeric characters")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '姓（全角）が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include("can't be blank")
      end 
      it '姓（全角）が半角だと登録できない' do
        @user.first_name = 'ｻﾄｳ'
        @user.valid?
        expect(@user.errors[:first_name]).to include("must be in Zenkaku")
      end 
      it '名（全角）が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include("can't be blank")
      end
      it '名（全角）が半角だと登録できない' do
        @user.last_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors[:last_name]).to include("must be in Zenkaku")
      end
      it '姓（カナ）が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("can't be blank")
      end
      it '名（カナ）が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("can't be blank")
      end
      it '姓（カナ）がカナ以外だと登録できない' do
        @user.first_name_kana = 'あ差r1@'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("must be in Katakana")
      end
      it '名（カナ）が空だと登録できない' do
        @user.last_name_kana = 'あ差r1@'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("must be in Katakana")
      end
      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors[:birth_date]).to include("can't be blank")
      end
    end
  end
end
