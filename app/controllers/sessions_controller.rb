class SessionsController < ApplicationController
  
  def new
    redirect_to posts_path if logged_in?
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "You've successfully logged in. Enjoy the best app ever."
      redirect_to posts_path
    else
      flash[:error] = "It looks like there was a problem with your email address or password, please try again."
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've successfully logged out. Have a good one!"
    redirect_to root_path
  end
end
