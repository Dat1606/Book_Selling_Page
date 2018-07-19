class StaticPagesController < ApplicationController
  before_action :find_book, :find_category, only: %i(create show home)
  before_action :load_request
  def home
    if logged_in?
      @feed_items = current_user.feed.order(:name).page params[:page]
      @categoryy = Category.new
      @book   = Book.new
      @like = Like.new
    end
    if params[:search]
      @books = Book.search(params[:search]).order(:name).page params[:page]
    else
      @books = Book.order(:name).page params[:page]
    end
    @requests = Request.all
    @incoming_requests = @requests.where(status: 1).order(:id).page params[:page]
  end

  def help; end

  def contact; end

   def search
    term = params[:term] || nil
    products = []
    products = Book.where('name LIKE ?', "%#{term}%") if term
    render json: products
  end

  private

  def find_book
    @books = Book.order(:name).page params[:page]
    book = Book.find_by id: params[:id]
  end

  def find_category
    @categories = Category.all
  end
end
