class Api::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def edit
    @user = User.find_by(id: params[:id])
    render :edit
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user && @user.update_attributes(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
