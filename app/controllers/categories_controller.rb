class CategoriesController < ApplicationController
  include CategoriesHelper
  before_action :logged_in_user
  before_action :admin_user, only: [:create, :destroy]
  before_action :load_request, :find_category

  def index
    @categories1 = Category.where(parent_id: 1)
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
    @categories1 = Category.where(parent_id: 1)
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

  def edit
    @categories1 = Category.where(parent_id: 1)
    @category = Category.find_by id: params[:id]
    @valid_categories = Category.where("parent_id != ?",@category.id )
    unless @category
      flash[:danger] = "Category not found"
      redirect_back(fallback_location: root_url)
    end
  end

  def update
    @category = Category.find_by id: params[:id]
    if @category.update_attributes(category_params)
      flash[:info] = "Category updated"
      redirect_back(fallback_location: root_path)
    end
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      @parent_category = Category.find_by(id: @category.parent_id)
      flash[:success] = "Category created!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = @category.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    if @category.destroy
       sql = "DELETE  from categories WHERE parent_id = #{@category.id} "
       records_array = ActiveRecord::Base.connection.execute(sql)
      flash[:success] = t "category_deleted"
    end
      # flash[:danger] = @category.errors.full_messages
    redirect_to categories_url
  end

  private

  def category_params
      params.require(:category).permit(:name,:parent_id)
  end

  def find_category
    @categories = Category.all
  end

end
