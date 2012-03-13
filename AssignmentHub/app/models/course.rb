class Course < ActiveRecord::Base
  has_many :assignments
  has_many :teachers
  has_many :attachments
  belongs_to :user
end
