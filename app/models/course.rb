class Course < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :teachers
  has_many :assignments
  has_many :attachments
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"
  
  #allows adding teachers (and TAs) from the course editing page, doesn't save blank names
  accepts_nested_attributes_for :teachers, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }
end
