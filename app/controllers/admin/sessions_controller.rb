class Admin::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if admin_user?
        flash[:info] = "Welcome Master!"
        redirect_to admin_requests_path
      else
      log_out if logged_in?
      flash[:danger] = t("invalid_login")
      redirect_back(fallback_location: root_url)
      end
    end
  end

  def new
    if logged_in?
      redirect_to admin_requests_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
