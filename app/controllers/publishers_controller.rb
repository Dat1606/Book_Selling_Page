class PublishersController < ApplicationController
   before_action :load_request, :find_category
   before_action :logged_in_user

  def show
    @publisher = Publisher.find_by id: params[:id]
    @books = Book.where(publisher_id: params[:id]).order(:name).page params[:page]
  end

  def index
    @publisher = Publisher.new
    @publishers = Publisher.all
  end

  def destroy
    @publisher = Publisher.find_by(id: params[:id])
    if @publisher.destroy
      flash[:success] = t "Publisher deleted"
    else
      flash[:danger] = @publisher.errors.full_messages
    end
    redirect_to publishers_url
  end

  def create
  @publisher = Publisher.new(publisher_params)
    if @publisher.save
      flash[:success] = "Publisher created!"
      redirect_to publishers_url
    else
       flash[:danger] = @publisher.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end
    private

    def publisher_params
      params.require(:publisher).permit(:name)
    end

  def find_category
    @categories = Category.all
    @category1 = Category.where(general_category_id: 1)
    @category2 = Category.where(general_category_id: 2)
    @category3 = Category.where(general_category_id: 3)
  end
end
