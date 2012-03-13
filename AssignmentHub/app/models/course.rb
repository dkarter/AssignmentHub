class Course < ActiveRecord::Base
  has_many Assignments
  has_many Teachers
  has_many Attachments
  belongs_to User
end
