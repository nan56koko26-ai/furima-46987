class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    
  end

  def new
    @item = Item.new
    @items = Item.includes(:user)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  

  private
  def item_params
    params.require(:item).permit(:name, :image, :description, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_time_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end