# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AssignmentHub::Application.initialize!

#Dorian: Default colors for courses
COURSE_COLORS = { 1 => "#ff6600",
                  2 => "#785f4b",
                  3 => "#56bb98",
                  4 => "#786575",
                  5 => "#000000" 
                }.freeze

# Configure our mailer
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => "smtp.sendgrid.net",
    :port => 25,
    :domain => "assignmenthub.herokuapp.com",
    :user_name => "app4054156@heroku.com",
    :password => "u40vubwf",
    :authentication => :plain
}