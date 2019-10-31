class CommentsController < ApplicationController
before_action :logged_in_user, only: [:create, :destroy]


  def create
    @book = Book.find_by(id: params[:book_id])
    @category = Category.find_by(id: params[:category_id])
    @comment = @book.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to category_book_path(@category,@book)
    else
      flash[:danger] = "Error"
      redirect_to category_book_path(@category,@book)
    end
  end

   private

  def comment_params
      params.require(:comment).permit(:content, :user_id, :book_id)
  end
end
