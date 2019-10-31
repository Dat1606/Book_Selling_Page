class StaticPagesController < ApplicationController
  before_action :find_book, only: %i(create show home)
  before_action :load_request
  def home
    if logged_in?
      @feed_items = current_user.feed.order(:name).page params[:page]
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
end
