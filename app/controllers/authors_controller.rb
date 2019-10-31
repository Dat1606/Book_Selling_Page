class AuthorsController < ApplicationController
   before_action :load_request
  def show
    @author = Author.find_by id: params[:id]
    @books = (Book.where author_id: params[:id]).order(:name).page params[:page]
  end

  def index
    @author = Author.new
    @authors = Author.all
  end

  def create
     @author = Author.new(author_params)
    if @author.save
      flash[:success] = "Author created!"
      redirect_to authors_url
    else
      flash[:danger] = "Cannot create author, author name must be exist"
      redirect_to authors_url
    end
  end

  def destroy
    @author = Author.find_by(id: params[:id])
    if @author.destroy
      flash[:success] = t "Publisher deleted"
    else
      flash[:danger] = @author.errors.full_messages
    end
    redirect_to authors_url
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end

end
