class AuthController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.create(auth_params)
    return json_response(@user.errors, :unprocessable_entity) unless @user.valid?

    @command = AuthenticateUser.call(@user.email, @user.password)

    response.status = :created
    respond_to do |format|
      format.json
    end
  end

  def login
    user_info = auth_params
    @command = AuthenticateUser.call(user_info[:email], user_info[:password])
    @user = User.find_by(email: user_info[:email])

    if @command.success?
      respond_to :json
    else
      json_response({success: false, error: @command.errors}, :unauthorized)
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:name, :email, :password, :picture)
  end
end
