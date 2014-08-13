class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # One of the first things I implemented.  Not sure if this still works, but probably best to leave it until the rest of the site is more complete first.
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @knocker = Knocker.find_for_facebook_oauth(request.env["omniauth.auth"])

    if @knocker.persisted?
      sign_in_and_redirect @knocker, :event => :authentication #this will throw if @knocker is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_knocker_registration_url
    end
  end

  def twitter
    auth = env["omniauth.auth"]

    @knocker = Knocker.find_for_twitter_oauth(request.env["omniauth.auth"],current_knocker)
    if @knocker.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in_and_redirect @knocker, :event => :authentication
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to new_knocker_registration_url
    end
  end

  def gplus
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @knocker = Knocker.find_for_gplus_oauth(request.env["omniauth.auth"])

    if @knocker.persisted?
      sign_in_and_redirect @knocker, :event => :authentication #this will throw if @knocker is not activated
      set_flash_message(:notice, :success, :kind => "Google+") if is_navigational_format?
    else
      session["devise.gplus_data"] = request.env["omniauth.auth"]
      redirect_to new_knocker_registration_url
    end
  end
end