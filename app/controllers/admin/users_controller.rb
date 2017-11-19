class Admin::UsersController < ApplicationController

  before_action :find_user

  def index
    authorize! :read, User
    @users = User.all
  end

  def new
    @user = User.new
    authorize! :create, User
    @restaurants = Restaurant.all

  end

  def edit
    authorize! :create, User
    @restaurants = Restaurant.all
  end

  def update
    authorize! :create, User
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    authorize! :destroy, User
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :restaurant_id, :role, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id]) if params[:id]
  end
end
