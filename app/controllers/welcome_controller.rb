class WelcomeController < ApplicationController
  skip_before_action :authenticate_request

  def index
  end

  def login
    uparams = user_params
    user = User.find_by(email: uparams[:email])

    if(user && user.authenticate(uparams[:password]))
      if(user.user_type.id == 1)
        session[:user] = user
        return redirect_to '/dashboard'
      else
        @error = 'Usted no cuenta con los permisos para continuar.'
      end
    else
      @error = 'El correo y/o la contraseña son incorrectos.'
    end

    render :index
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
