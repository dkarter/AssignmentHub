class Teacher < ActiveRecord::Base
  has_and_belongs_to_many :courses
  
  validates_presence_of :first, :last
  validates_length_of :first, :last, :maximum => 15, :message => "less than 15 characters please"
  validates_length_of :email, :maximum => 40, :message => "less than 40 characters please"
  validates_length_of :office_hours, :maximum => 50, :message => "less than 50 characters please"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  
  # i wouldn't do that.. what if two users create the same professor record?
  # we need to make the record belong to user
  #validates_uniqueness_of :email
  
  
  
  TITLETYPE = [['Prof.', '4'],
  ['Dr.', '3'],
  ['Mrs.', '2'],
  ['Ms.', '1'],
  ['Mr.', '0']]

  
  has_attached_file :photo, 
                    :default_url => "/assets/NA_:style.jpg", 
                    :styles => {:large => "300x300>", 
                                :small => "150x150>", 
                                :thumb => "57x75#"}
                                                  
  
  
  def self.GetTitleFromValue(value)
    temp = TITLETYPE.select{ |x| x[1] == value.to_s() }.first
    return temp ? temp.first : ''
  end
end
