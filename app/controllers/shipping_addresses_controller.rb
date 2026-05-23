class ShippingAddressesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root_if_seller, only: [:index, :create]

  def create
    @purchase = Purchase.new(user: current_user, item: @item, token: params[:token])
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
end
