class OmniauthCallbacksController < ApplicationController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
  end
end
