class BooksController < ApplicationController

before_action :baria_user, only: [:edit, :destroy]

  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
    @users = current_user
    @book_comment =  BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully'
    else
      @user = current_user
      @books = Book.all
      render "index"
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have updated book successfully'
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path(@book.id)

  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def baria_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
        redirect_to books_path
    end
  end
end