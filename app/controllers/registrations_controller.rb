class RegistrationsController < Devise::RegistrationsController
	# This was an attempt to include an additional step to the registration process, to allow users to enter basic account details on registration, then basic profile details once their account is verified.  Don't think I got very far with it though.

  protected

  def after_sign_up_path_for(resource)
    edit_knocker_profile_path(resource)
  end
end