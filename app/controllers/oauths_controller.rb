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
    if (@user = current_user)
      save_line_id(provider)
    elsif (@user = login_from(provider))
      redirect_back_or_to root_path, notice: "Logged in from #{provider.titleize}!"
    else
      new_user_login(provider)
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def new_user_login(provider)
    @user = create_from(provider)
    @user.update!(line_user_id: @user.email)
    # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
    reset_session # protect from session fixation attack
    auto_login(@user)
    redirect_back_or_to root_path, notice: "Logged in from #{provider.titleize}!"
  rescue StandardError
    redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
  end

  def save_line_id(provider)
    get_line_id(provider)
    if @user.update(line_user_id: @user_hash[:uid])
      flash[:success] = "ラインIDを登録しました"
    else
      flash[:danger] = "ラインID登録に失敗しました"
    end
    redirect_back_or_to root_path
  end

  def get_line_id(provider_name, _should_remember: false)
    sorcery_fetch_user_hash provider_name
  end
end
