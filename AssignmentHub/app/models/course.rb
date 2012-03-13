class Course < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :teachers
  has_many :assignments
  has_many :attachments
end
