ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app11912931@heroku.com'],
  :password       => ENV['nxioywli'],
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method ||= :smtp