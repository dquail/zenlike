class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :check_layout
  
  before_filter :authorize
  helper_method :current_user
  helper_method :current_host_type
  
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

  def current_host_type
    turker_host_names = ['lvh.me', 'turk.zenlike.me', 'makemeeting.info']      
    meeting_host_names = ['meetings.zenlike.me', 'localhost']
    myassistant_host_names = ['myassistant.zenlike.me', 'localhost']
    if (turker_host_names.include?(request.host))
      return 'Turker'
    elsif(meeting_host_names.include?(request.host))
      return 'Meeting'
    elsif(myassistant_host_names.include?(request.host))
      return 'Assistant'
    end
  end 
  
  def check_layout
    if (self.current_host_type == 'Turker')
      return 'turker_application'
    elseif (self.current_host_type == 'Meeting')
      return 'meeting_application'
    elseif (self.current_host_type == 'Assistant')
      return 'assistant_application'
    else
      return 'application'
    end
  end  
end