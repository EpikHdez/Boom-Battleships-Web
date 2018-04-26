class ItemController < ApplicationController
  before_action :authenticate_noapi_request, only: [:create, :update, :delete]
  before_action :authenticate_request, only: [:buy]
  before_action :admin?, only: [:create, :update, :delete]

  def index
    @items = Item.all

    respond_to do |format|
      format.json
    end
  end

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.json
    end
  end

  def buy
    @item = Item.find(params[:item_id])
    info = params.permit(:item_id, :quantity)
    total_price = @item.price * Integer(info[:quantity])

    return json_response(success: false) unless @current_user.money >= total_price
    inventory = @current_user.inventories.find_by(item_id: info[:item_id])

    if(!inventory)
      @current_user.inventories.create!(info)
    else
      info[:quantity] = Integer(info[:quantity]) + inventory.quantity
      inventory.update!(quantity: info[:quantity])
    end

    money = @current_user.money - @item.price

    @current_user.update!(money: money)

    response.status = :created
    json_response(success: true)
  end

  def create
    info = item_params
    @item = Item.create!(info)

    response.status = :created
    respond_to do |format|
      format.json
    end
  end

  def update
    @item = Item.find(params[:id])
    info = item_params
    @item.update!(info)

    respond_to do |format|
      format.json
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :picture)
  end
end
