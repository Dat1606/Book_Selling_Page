class Admin::BooksController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]
  before_action :load_show, only: :show

  def index
    @category = Category.first
    @new_book = Book.new
    @book = Book.find_by id: params[:id]
    if params[:search]
      @books = Book.search(params[:search]).order(:name).page params[:page]
    else
      @books = Book.includes(:category, :author).references(:book_likes).page params[:page]
    end
  end

  def create
    @book = Book.new(book_params)
    if (@book.number > 0)  && @book.save
      flash[:success] = "Book created!"
      #redirect_to new_category_book_path(@category)
      redirect_back(fallback_location: root_path)
    else

      flash[:danger] =  @book.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @category = Category.find_by id: params[:category_id]
    @book = Book.find_by(id: params[:id])
    if @book.update_attributes(book_params)
    flash[:success] = "Book updated"
    redirect_back(fallback_location: root_url)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    if @book.destroy
      flash[:success] = t "book_deleted"
    else
      flash[:danger] = @book.errors.full_messages
    end
    redirect_to root_url
  end

private

  def book_params
      params.require(:book).permit(:name, :description, :picture,:category_id, :user_id, :author_id, :publisher_id, :number)
  end

  def load_show
    @books = Book.order(:name).page params[:page]
    @book = Book.find(params[:id])
    @category = Category.find_by id: params[:category_id]
    @user = current_user
  end
end
