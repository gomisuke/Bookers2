class UsersController < ApplicationController
before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end
  
  def index
  	@users = User.all
  	@user = User.find(current_user.id)              #要修正
  	@book = Book.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
