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
    @user =User.new
    @categories = Category.where(parent_id: 1)
  end
end
