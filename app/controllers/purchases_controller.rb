class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root_if_seller, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase = Purchase.new
    
  end

  def create
    @purchase = Purchase.new(user: current_user, item: @item, token: params[:token])
    @shipping_address = @purchase.build_shipping_address(shipping_address_params)
    if @purchase.valid? && @shipping_address.valid?
      ActiveRecord::Base.transaction do
        pay_item
        @purchase.save
        @shipping_address.save
        return redirect_to root_path
      end
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def shipping_address_params
    params.require(:purchase).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root_if_seller
    if current_user && @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: params[:token] ,    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
