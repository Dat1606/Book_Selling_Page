class BooksController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]
  before_action :load_show, only: :show
  before_action :load_request
  before_action :logged_in_user, :find_category

  def index
    @books = Book.order(:name).page params[:page]
     if params[:search]
      @books = Book.search(params[:search]).order(:name).page params[:page]
    else
      @books = Book.order(:name).page params[:page]
    end
  end

  def show
    @books = Book.order(:name).page params[:page]
    @request = Request.new()
    @categories = Category.all
    @author = Author.find_by id: @book.author_id
    @publisher = Publisher.find_by id: @book.publisher_id
    @book = Book.find_by id: params[:id]
    @comment = Comment.new
    @comments = Comment.where(book_id: params[:id])
    @confirmed_requests = Request.where(book_id: @book.id, status: 2)
    @category = Category.find_by id: params[:category_id]
  end

  def create
    @category = Category.find_by id: params[:category_id]
    @book = @category.books.build(book_params)
    if (@book.number > 0)  && @book.save
      flash[:success] = "Book created!"
      #redirect_to new_category_book_path(@category)
      redirect_back(fallback_location: root_path)
    else

      flash[:danger] =  @book.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @category = Category.find_by id: params[:category_id]
    @book = Book.find_by(id: params[:id])
    unless @book
      flash[:danger] = "Book not found"
      redirect_back(fallback_location: root_url)
    end
  end

  def update
    @category = Category.find_by id: params[:category_id]
    @book = Book.find_by(id: params[:id])
    if @book.update_attributes(book_params)
    flash[:success] = "Book updated"
    redirect_to category_book_path(@category,@book)
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

  def new
    @category = Category.find_by id: params[:category_id]
    @book = Book.new
    @books = Book.order(:name).page params[:page]
  end

  private

  def book_params
      params.require(:book).permit(:name, :description, :picture,:category_id, :user_id, :author_id, :publisher_id, :number)
  end

  def load_show
    @book = Book.find(params[:id])
    @category = Category.find_by id: params[:category_id]
    @user = current_user
  end

  def find_category
    @categories = Category.all
  end

end
