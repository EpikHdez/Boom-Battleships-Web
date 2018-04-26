class DashboardController < ApplicationController
  skip_before_action :authenticate_request
  before_action :authenticate_noapi_request

  def index
    @users = User.all
  end

  def logout
    session[:user] = nil
    redirect_to '/'
  end
end
