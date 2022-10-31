class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    # @items = Item.all.order(created_at: 'DESC')
    @items = []
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @item.user == current_user
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user_id
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:product_name, :product_detail, :category_id, :product_condition_id, :delivery_fee_id, :area_id,
                                 :days_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end
end
