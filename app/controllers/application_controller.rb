class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  
    private
  
    def current_user
      Rails.logger.debug("User ID in session: #{session[:user_id].inspect}") # ajoutez cette ligne pour le débogage
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
  
    def logged_in?
      !!current_user
    end
  
    helper_method :current_user, :logged_in?
  end
  