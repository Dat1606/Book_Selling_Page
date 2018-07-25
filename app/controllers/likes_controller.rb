class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:like][:book_id]
    current_user.like @book
    respond_to do |format|
      format.js
    end
  end

  def destroy
    id = Like.find_by(id: params[:id]).book_id
    @book =  Book.find_by id: id
    current_user.unlike id
    respond_to do |format|
      format.js
    end
  end
  private

  def like_params
      params.require(:like).permit(:book_id, :user_id)
  end
end
