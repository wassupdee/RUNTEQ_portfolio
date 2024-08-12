# app/controllers/oauths_controller.rb
class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if provider.nil?
      logger.error "Provider is nil!"
      redirect_to root_path, alert: "Invalid provider"
      return
    end

    if @user.nil?
      logger.error "User not found from provider: #{provider}"
      redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      return
    end
    if @user = login_from(provider)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  #example for Rails 4: add private method below and use "auth_params[:provider]" in place of
  #"params[:provider] above.

    private

    def auth_params
        params.permit(:code, :provider, :error, :state)
    end

end
