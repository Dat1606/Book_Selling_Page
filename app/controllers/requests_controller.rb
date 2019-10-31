class RequestsController < ApplicationController
   before_action :logged_in_user
   before_action :find_book, only: %i(create)
   before_action :load_request

  def create
    @request = Request.new(request_params)
    @request.book_id = @book.id
    @request.user_id = current_user.id
    @request.status = 1
    if @request.save
      flash[:success] = "Request created!"
      redirect_back(fallback_location: root_path)
    else
     flash[:danger] = @request.errors.full_messages
     redirect_back(fallback_location: root_path)
    end
  end

  def show
    @category = Category.find_by id: params[:category_id]
    @request = Request.find_by(id: params[:id])
    @book = Book.find_by(id: @request.book_id)
    @user = User.find_by(id: @request.user_id)
  end

  def update
    @request = Request.find_by(id: params[:id])
     @book = Book.find_by id: @request.book_id
    if params[:request].keys.first == "status" && params[:request].values.first == "2"
      @request.update_attribute(:status,2) && @book.number > 0
      @book.update_attribute(:number, (@book.number-=1))
      flash[:info] = "OK"
    elsif params[:request].keys.first == "status" && params[:request].values.first == "4"
     @request.update_attribute(:status, 4)
      @book.update_attribute(:number, (@book.number+=1))
      flash[:info] = "OK"
    elsif params[:request].keys.first == "status" && params[:request].values.first == "3"
      @request.update_attribute(:status, 3)
      flash[:info] = "OK"
    elsif params[:request].keys.first == "status" && params[:request].values.first == "5"
      @request.update_attribute(:status, 5)
      flash[:info] = "OK"
    else
      flash[:info] = "Cannot accept request, we've currently ran out of this book"
    end
      redirect_to requests_url
  end

  def index
    if logged_in?
      @request = Request.find_by(id: params[:id])
      #@book = Book.find_by(id: @request.book_id)
      @requests = current_user.find_requests
      if admin_user?
        @requests = Request.all
      end
      if params[:requests]
        @requests = @requests.where status: params[:requests]
        respond_to :js
        if params[:requests] == "0"
        @requests = current_user.find_requests
        @requests = Request.all if admin_user?
        respond_to :js
        end
      end
    end
  end

  def incoming_requests
    @requests = current_user.find_requests
      if admin_user?
        @requests = Request.all
      end
    @incoming_requests = @requests.where(status: 1).order(:id).page params[:page]
  end

  def confirmed_requests
    @requests = current_user.find_requests
      if admin_user?
        @requests = Request.all
      end
    @confirmed_requests = (@requests.where(status: 2 )).order(:id).page params[:page]
  end

  def received_requests
    @requests = current_user.find_requests
      if admin_user?
        @requests = Request.all
      end
    @received_requests =  (@requests.where(status: 3 )).order(:id).page params[:page]
  end

  def returned_requests
    @requests = current_user.find_requests
      if admin_user?
        @requests = Request.all
      end
    @returned_requests =  (@requests.where(status: 5 )).order(:id).page params[:page]
  end

  def rejected_requests
   @requests = current_user.find_requests
      if admin_user?
        @requests = Request.all
      end
    @rejected_requests = @requests.where(status: 4).order(:id).page params[:page]
  end

  def destroy
    @request = Request.find_by(id: params[:id])
    if @request.destroy
      flash[:success] = "Request deleted"
    else
      flash[:danger] = @request.errors.full_messages
    end
    redirect_to requests_url
  end

private

  def request_params
    params.require(:request).permit(:book_id, :user_id, :borrow_date, :return_date)
  end

  def find_book
    @book = Book.find_by id: params[:request][:book_id]
  end
end
