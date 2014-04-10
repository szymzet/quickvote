class OmniauthCallbacksController < ApplicationController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'])
    sign_in @user, event: :authentication
    redirect_to(request.env['omniauth.origin'] || root_path)
  end
end
