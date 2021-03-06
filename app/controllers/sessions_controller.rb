class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if admin_user?
        flash[:info] = "Welcome Master!"
      end
      redirect_to root_url
    else
      flash[:danger] = t("invalid_login")
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
