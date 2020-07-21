# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
    
  end

  def logged_in?
    !!current_user
  end

  def authorized
    unless logged_in?
      flash[:error] = "You're not authorized to do that. Please log in."
      redirect_to root_path 
    end
  end
end
