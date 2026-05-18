class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :ensure_owner, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end


  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end
  
  def edit
    
  end

  def update
    if @item.update(item_params_for_update)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_time_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_owner
    if @item.user != current_user then redirect_to root_path
    end
  end

  def item_params_for_update
    params.require(:item).permit(:name, :image, :description, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_time_id)
  end

end