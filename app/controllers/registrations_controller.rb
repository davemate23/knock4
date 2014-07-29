class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    edit_knocker_profile_path(resource)
  end
end