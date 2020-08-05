class BooksController < ApplicationController
before_action :authenticate_user!, :except => [:top, :about]
before_action :correct_user, only:[:edit]

  def top
  end

  def about
  end

  def index
  	@books = Book.all
  	@book = Book.new
  	@user = User.find(current_user.id)
  end

  def new
  end

  def create
  	@book = Book.new(book_params)
    @book.user = current_user
  	if @book.save
      flash[:notice] = "You have creatad book successfully."
  	  redirect_to books_path
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render 'index'
    end
  end

  def show
      @post = Book.find(params[:id])
      @user = User.find(@post.user.id)
      @book = Book.new
      @comment = BookComment.new
      @comments = BookComment.where(book_id: params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    if book.user_id != current_user.id
      redirect_to books_path
    end
  end

  
end
