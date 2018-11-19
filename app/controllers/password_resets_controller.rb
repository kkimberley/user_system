class PasswordResetsController < ApplicationController
  def new; end

  def edit
    @user = User.find_by_reset_digest!(params[:id])
  end

  def create
    @user = User.find_by email: params[:email]
    if @user
      @user.send_password_reset_email
      message = 'Email sent with password reset instructions'

      redirect_to new_session_path, notice: message
    else
      message = 'Email address not found.'

      redirect_to new_password_reset_path, notice: message
    end
  end

  def update
    @user = User.find_by_reset_digest!(params[:id])
    @user.attributes = user_params

    if @user.reset_send_at < 6.hours.ago
      message = 'Token had Expired.'

      redirect_to new_password_reset_path, notice: message
    elsif @user.save(validate: false)
      redirect_to new_session_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(%i[password password_confirmation])
  end
end
