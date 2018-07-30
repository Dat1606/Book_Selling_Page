class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:create, :destroy]
  before_action :load_request, :find_category

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

  def new
    @category = Category.new
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
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created!"
      redirect_to categories_url
    else
      flash[:danger] = @category.errors.full_messages
      redirect_back(fallback_location: root_path)
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
      params.require(:category).permit(:name,:general_category_id)
  end

  def find_category
    @categories = Category.all
    @category1 = Category.where(general_category_id: 1)
    @category2 = Category.where(general_category_id: 2)
    @category3 = Category.where(general_category_id: 3)
  end
end
