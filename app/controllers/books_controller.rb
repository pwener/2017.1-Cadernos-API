class BooksController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    @books = Book.all
    render json: @books
  end

  def show
    @book = Book.find params[:id]
    render json: @book
  end

  def set_both
    @user = User.find(params[:id])

    @book = @user.books.find_by_title(params[:title])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render json: @book.destroy
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title)
    end
end
