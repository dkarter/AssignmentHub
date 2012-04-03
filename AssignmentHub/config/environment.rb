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

# Configure our mailer (currently causes some problems)
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.server_settings = {
#    :address => "localhost",
#    :port => 25,
#    :domain => "localhost",
#    :user_name => "AssignmentHub",
#    :password => "rocktheparty",
#    :authentication => :login
#}
