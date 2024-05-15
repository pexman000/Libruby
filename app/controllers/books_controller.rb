class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_seller, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @books = @books.where("title LIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  def show
  end

  def return
    @book = Book.find(params[:id])
    @user = current_user
    @borrow = Borrow.find_by(user: @user, book: @book)
  
    if @borrow.present? && @borrow.destroy
      redirect_to books_path, notice: "Book returned successfully."
    else
      redirect_to books_path, alert: "Failed to return the book."
    end
  end

  def borrow
    @book = Book.find(params[:id])
    @user = current_user
    @borrow = Borrow.new(user: @user, book: @book, started_at: DateTime.now)

    if @borrow.save
      redirect_to books_path
    else
      redirect_to @book, alert: "Failed to borrow the book."
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publish_year)
  end

  def require_seller
    unless current_user && current_user.seller?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end
end
