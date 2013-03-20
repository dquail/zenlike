class OauthSessionsController < ApplicationController
  
  def create     
    @auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    token = @auth["credentials"]["token"]
    refresh_token = @auth["credentials"]["refresh_token"]
    
    current_user.google_access_token = token
    current_user.google_refresh_token = refresh_token
    
    current_user.save!
    
    redirect_to edit_user_registration_url, :notice => 'Successfully added google calendar'
  end
end