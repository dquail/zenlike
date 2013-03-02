class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :check_layout
  
  before_filter :authorize
  helper_method :current_user
  
  protected
  
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to log_in_url, notice: "You must first log in"
    end
    @current_user = self.current_user
  end 
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_layout
    turker_host_names = ['lvh.me', 'turk.zenlike.me', 'makemeeting.info']  
    turker_host_names.include?(request.host) ? "turker_application" : "application" 
  end  
end