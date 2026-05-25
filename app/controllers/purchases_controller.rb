class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root_if_seller, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_shipping = PurchaseShipping.new
    
  end

  def create
    @purchase_shipping = PurchaseShipping.new(shipping_address_params)
    if @purchase_shipping.valid?
      @purchase_shipping.token = params[:token]
        pay_item
        @purchase_shipping.save
        return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def shipping_address_params
    params.require(:purchase_shipping).permit(:token, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user: current_user,  item: @item)
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
