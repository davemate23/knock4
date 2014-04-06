class RegistrationsController < Devise::RegistrationsController
  def update
    @knocker = Knocker.find(current_knocker.id)

    successfully_updated = if needs_password?(@knocker, params)
      @knocker.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:knocker].delete(:current_password)
      @knocker.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the knocker bypassing validation in case his password changed
      sign_in @knocker, :bypass => true
      redirect_to after_update_path_for(@knocker)
    else
      render "edit"
    end
  end

  private

  # check if we need password to update knocker data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(knocker, params)
    knocker.email != params[:knocker][:email] ||
    knocker.username != params[:knocker][:username] ||
      params[:knocker][:password].present?
  end
end