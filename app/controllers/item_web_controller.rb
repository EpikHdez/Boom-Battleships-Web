class ItemWebController < ApplicationController
  skip_before_action :authenticate_request
  before_action :authenticate_noapi_request

  def index
    @items = Item.all.order(:id)
  end

  def create
    info = item_params
    cloudinary_base_url = 'http://res.cloudinary.com/epikhdez/'
    info[:picture] = cloudinary_base_url + info[:picture]

    Item.create!(info)

    @items = Item.all
    render :index
  end

  private

  def item_params
    params.permit(:name, :price, :picture)
  end
end
