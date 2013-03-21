GOOGLE_CLIENT_ID = "178308103577.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET = "5tBnvozVPtSAfI2WlRWq8jIY"
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }
  
end
