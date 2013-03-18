class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :create_zendesk_link
  
  layout :check_layout
  
  helper_method :current_host_type
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  protected
  
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
  
  def create_zendesk_link
    if current_user && current_user.subscription && current_user.subscription.plan.name == "Platinum"
      timestamp = Time.now.utc.to_i
      #string = "David Quail" + "david_quail@hotmail.com" + ZENDESK_REMOTE_AUTH_TOKEN + timestamp.to_s
      #@zendesk_login_link = ZENDESK_REMOTE_AUTH_URL + "?name=David%20Quail&email=david_quail@hotmail.com&timestamp=#{timestamp}&hash=#{hash}"
      string = "First Last" + "first.last@gmail.com" + ZENDESK_REMOTE_AUTH_TOKEN + timestamp.to_s
      hash = Digest::MD5.hexdigest(string)
      @zendesk_login_link = ZENDESK_REMOTE_AUTH_URL +  "?name=First%20Last&email=first.last@gmail.com&timestamp=#{timestamp}&hash=#{hash}"
    end

    

  end
  
end