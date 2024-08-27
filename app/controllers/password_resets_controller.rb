class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :set_user_by_token, only: %i[update]

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    flash[:success] = "パスワードリセットのメールを送信しました"
    redirect_to login_path
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      flash[:success] = "パスワードがリセットされました"
      redirect_to login_path
    else
      flash.now[:danger] = "パスワードリセットに失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end
end
