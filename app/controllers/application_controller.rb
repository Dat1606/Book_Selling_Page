class ApplicationController < ActionController::Base
  before_action :create_likes, :find_category
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end

  def create_likes
    @like = Like.new
  end

  def find_category
    @categories = Category.all
    @category1 = Category.where(general_category_id: 1)
    @category2 = Category.where(general_category_id: 2)
    @category3 = Category.where(general_category_id: 3)
  end
end
