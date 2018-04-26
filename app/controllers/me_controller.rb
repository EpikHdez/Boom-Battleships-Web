class MeController < ApplicationController
  def show
    respond_to do |format|
      format.json
    end
  end

  def update
    @current_user.update(me_params)
    
    respond_to do |format|
      format.json
    end
  end

  def destroy
    @current_user.destroy
    head :no_content
  end

  private

  def me_params
    params.require(:me).permit(:name, :email, :password, :picture, :money)
  end
end
