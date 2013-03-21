class GoogleUser < ActiveRecord::Base
  attr_accessible :email, :google_access_token, :google_expires_at, :google_refresh_token
  
  def refresh_token
    data = {
      :client_id => GOOGLE_CLIENT_ID,
      :client_secret => GOOGLE_CLIENT_SECRET,
      :refresh_token => self.google_refresh_token,
      :grant_type => 'refresh_token'
    }
    
    @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    Rails.logger.info "Received response updating system token"
    
    if @response["access_token"].present?
      self.google_access_token = @response["access_token"]
      self.google_expires_at = @response["expires_at"]
      self.save!
      Rails.logger.info "Returning a new access token"
      return @response["access_token"]
    else
      Rails.logger.error "Couldn't generate a new token"
      return nil
    end
    
  rescue RestClient::BadRequest => e
    Rails.logger.error "Bad request when refreshing google token for system user"
  rescue
    Rails.logger.error "Unknown error when refreshing google system user token"
  end

end
