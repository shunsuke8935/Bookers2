class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, except: [:index, :show]
  def show
  	@book = Book.new
  	@user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(current_user.id)


  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
  else
    render :edit
  end
  end
  def create
  	book = Book.new(book_params)
  end

  def index
  	@book = Book.new
  	@books = Book.all
  	@user = User.find(current_user.id)
  	@users = User.all
  end

  private

  def user_params
  	params.require(:user).permit(:name, :image, :introduction)
  end
  def correct_user
    user = User.find(params[:id])
     if current_user != user
      redirect_to books_path
    end
  end

end
