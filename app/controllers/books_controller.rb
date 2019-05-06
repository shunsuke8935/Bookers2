class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]

  def index
  	@book = Book.new
  	@books = Book.all
  	@user = User.find(current_user.id)
  end

  def destroy
    book = Book.find(params[:id])
    if book.user_id == current_userid
      book.destroy
      redirect_to books_path
    end
  end

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
      flash[:notice] = "You have creatad book successfully."
  	  redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    end
  end
  
  private

  def book_params
  	params.require(:book).permit(:title, :option)
  end

  def correct_user
     if current_user != Book.find(params[:id]).user
      redirect_to books_path
    end
  end
end
