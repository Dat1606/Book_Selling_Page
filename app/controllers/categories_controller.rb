class CategoriesController < ApplicationController
  before_action :logged_in_user, :admin_user, only: [:create, :destroy]
   before_action :load_request

  def index
    @categories = Category.order(:name).page params[:page]
    @books = Book.find_by category_id: params[:id]
    @category = Category.new
    if params[:search]
      @categories = Category.search(params[:search]).order(:name).page params[:page]
    else
      @categories = Category.order(:name).page params[:page]
    end
  end

  def show
    @category = Category.find_by id: params[:id]
    @book = Book.new
    @books = Book.where(category_id: params[:id]).order(:id).page params[:page]
    @categories = Category.all
    if params[:search]
      @books = @books.search(params[:search]).order(:name).page params[:page]
    else
      @books = @books.order(:name).page params[:page]
    end
  end

  def create
     @category = admin_user.categories.build(category_params)
    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    if @category.destroy
      flash[:success] = t "category_deleted"
    else
      flash[:danger] = @category.errors.full_messages
    end
    redirect_to root_url
  end

  private

  def category_params
      params.require(:category).permit(:name,:user_id)
  end
end
