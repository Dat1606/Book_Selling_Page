class StaticPagesController < ApplicationController
  before_action :find_book, :find_category, only: %i(create show home)
  before_action :load_request
  def home
    if logged_in?
      @feed_items = current_user.feed.order(:name).page params[:page]
      @categoryy = Category.new
      #@book   = Book.new
      @like = Like.new
      @request = Request.new
    end
    if params[:search]
      @books = Book.search(params[:search]).order(:name).page params[:page]
    else
      @books = Book.order("name DESC")
    end
    @requests = Request.all
    @incoming_requests = @requests.where(status: 1).order(:id).page params[:page]
  end

  def help; end

  def contact; end

  private

  def find_book
    @books = Book.order("name DESC")
    @book2 = Book.last(4)
    @book = Book.find_by id: params[:id]
  end

  def find_category
    @categories = Category.all
    @category1 = Category.where(general_category_id: 1)
    @category2 = Category.where(general_category_id: 2)
    @category3 = Category.where(general_category_id: 3)
  end
end
