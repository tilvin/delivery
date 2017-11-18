class UsersController < ApplicationController

  before_action :set_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

    def set_user
      @user = User.find(params[:id]) if params[:id]
    end


    def user_params
      params.require(:user).permit(:email, :crypted_password, :salt, :password_confirmation, :password, :restaurant_id, :role)
    end
end
