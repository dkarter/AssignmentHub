class Teacher < ActiveRecord::Base
  has_and_belongs_to_many :courses
  
  validates_presence_of :first, :last, :email
  validates_length_of :first, :last, :maximum => 15, :message => "less than 15 characters please"
  validates_length_of :email, :maximum => 25, :message => "less than 25 characters please"
  validates_length_of :office_hours, :maximum => 50, :message => "less than 50 characters please"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_uniqueness_of :email
  
  
  TITLETYPE = [['Prof.', '4'],
  ['Dr.', '3'],
  ['Mrs.', '2'],
  ['Ms.', '1'],
  ['Mr.', '0']]

  
  has_attached_file :photo, :styles => {:thumb => "150x150>"}          
end
