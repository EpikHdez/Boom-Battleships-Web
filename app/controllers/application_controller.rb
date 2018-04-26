class ApplicationController < ActionController::Base
  before_action :authenticate_request  
  attr_reader :current_user  
    
  private  
    
  def authenticate_request  
    @current_user = AuthorizeApiRequest.call(request.headers).result  
    json_response({success: false, error: 'Not Authorized' }, 401) unless @current_user  
  end

  def authenticate_noapi_request
    @current_user = session[:user]

    redirect_to '/' unless @current_user
  end

  def admin?
    if @current_user.is_a?(Hash)
      if @current_user['user_type_id'] != 1
        json_response({success: false, error: 'Not Authorized' }, 401)
      end
    else
      if @current_user.user_type.id != 1
        json_response({success: false, error: 'Not Authorized' }, 401)
      end
    end
  end 
    
  include Response 
end
