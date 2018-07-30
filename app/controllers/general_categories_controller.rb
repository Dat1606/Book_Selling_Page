class GeneralCategoriesController < ApplicationController
 before_action :load_request, :find_category

  def index
    @general_category = GeneralCategory.new
    2.times {@general_category.categories.build}
  end

  def create
    @general_category = GeneralCategory.create(category_params)
    if @general_category.save
      flash[:success] = "Category created!"
      redirect_back(fallback_location: root_url)
    else
       flash[:danger] = @general_category.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def category_params
   params.require(:general_category).permit(:name,categories_attributes: [:name])
  end
  def find_category
    @categories = Category.all
    @category1 = Category.where(general_category_id: 1)
    @category2 = Category.where(general_category_id: 2)
    @category3 = Category.where(general_category_id: 3)
  end
end
