class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def create
    build_resource sign_up_params.merge role: :member
    if resource.save
      set_flash_message! :notice, :signed_up_but_unconfirmed
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  private
  def configure_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:first_name, :last_name]
  end
end
