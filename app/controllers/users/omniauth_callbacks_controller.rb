class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    authenticate_with_omniauth
  end

  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to user_facebook_omniauth_authorize_path auth_type: :rerequest, scope: :email
    else
      authenticate_with_omniauth
    end
  end

  private
  def authenticate_with_omniauth
    user = User.from_omniauth request.env["omniauth.auth"]
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = t ".login_as", name: user.decorate.full_name
    else
      redirect_to new_user_registration_path, alert: user.errors.full_messages.to_sentence
    end
  end
end
