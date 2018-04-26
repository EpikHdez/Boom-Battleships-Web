class UserItemController < ApplicationController
  def index
    @inventories = @current_user.inventories

    respond_to do |format|
      format.json
    end
  end

  def use_item
    inventory = @current_user.inventories.find_by(item_id: params[:id])
    inventory.quantity -= 1

    if inventory.quantity == 0
      inventory.destroy
    else
      inventory.save
    end

    head :no_content
  end
end
