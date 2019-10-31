class FollowBooksController < ApplicationController
  before_action :logged_in_user
   def create
    book_id = Book.find_by id: params[:like][:book_id]
    current_user.like book_id
    redirect_back(fallback_location: root_path)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    book_id = Like.find_by(id: params[:id]).book_id
    current_user.unlike book_id
    redirect_to root_url
  end
  private

  def like_params
      params.require(:like).permit(:book_id, :user_id)
  end
end
