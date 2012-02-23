class User < ActiveRecord::Base
  # Validation of various parameters. Important: require valid email format, unique username
  validates_length_of :name, :within => 3..15
  validates_length_of :password, :within => 5..40
  validates_presence_of :name, :password, :first, :last, :email, :user_type
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_uniqueness_of :name
end
