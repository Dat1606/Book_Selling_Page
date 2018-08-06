class BooksController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]
  before_action :load_show, only: :show

  def index
    @books = Book.order(:name).page params[:page]
     if params[:search]
      @books = Book.search(params[:search]).order(:name).page params[:page]
    else
      @books = Book.order(:name).page params[:page]
    end
  end

  def show
    @user = User.new
    @request = Request.new()
    @comment = Comment.new
    @comments = Comment.where(book_id: params[:id])
  end

private

  def load_show
    @books = Book.order(:name).page params[:page]
    @book = Book.find(params[:id])
    @category = Category.find_by id: params[:category_id]
    @user = current_user
  end
end
