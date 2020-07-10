class UsersController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only:[:edit]
  
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
      flash[:notice] = "You have updated user successfully."
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

  def correct_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id)
    end
  end

end
