class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit , :update, :destroy]
before_action :correct_user, only: [:edit, :update]
before_action :load_user, only: [:destroy, :show]
before_action :admin_user, only: :destroy
before_action :load_category, only: :show
before_action :load_request

  def index
    @users = User.order(:name).page params[:page]
    if params[:search]
      @users = User.search(params[:search]).order(:name).page params[:page]
    else
      @users = User.order(:name).page params[:page]
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "greeting"
      redirect_to root_path
    else
      flash[:danger] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    @requests = @user.find_requests
  end

  def edit
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to users_url
    end
  end

  def update
    if @user.update_attributes user_params
    flash[:success] = t "profile_updated"
    redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = @user.errors.full_messages
    end
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.order(:id).page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.order(:id).page params[:page]
    render 'show_follow'
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to users_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user?(@user)
    flash[:danger] = t "user_not_found"
    redirect_to root_path
  end

  def load_category
    @categories = Category.all
     @category1 = Category.where(general_category_id: 1)
    @category2 = Category.where(general_category_id: 2)
    @category3 = Category.where(general_category_id: 3)
  end

end
