# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AssignmentHub::Application.initialize!

# Configure our mailer (currently causes some problems)
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.server_settings = {
    :address => "localhost",
    :port => 25,
    :domain => "localhost",
    :user_name => "AssignmentHub",
    :password => "rocktheparty",
    :authentication => :login
#}
