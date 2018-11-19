class UsersController < ApplicationController
  before_action :authorize, only: %i[edit update]

  def edit
    @user = User.find params[:id]
  end

  def update
    user = User.find params[:id]
    message = if user.update(user_params(__method__))
                'update successfully.'
              else
                "update fail, #{user.errors.messages}"
              end

    redirect_to edit_user_path(user), notice: message
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params(__method__))
    if user.save
      session[:user_id] = user.id

      UserMailer.welcome_mail(user).deliver
      redirect_to edit_user_path(user)
    else
      redirect_to root_path, notice: "signup fail, #{user.errors.messages}"
    end
  end

  private

  def user_params(action)
    permit_params = if action == :create
                      %i[email password password_confirmation]
                    else
                      %i[username password]
                    end

    params.require(:user).permit(permit_params)
  end
end
