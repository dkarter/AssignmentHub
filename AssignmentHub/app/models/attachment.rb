class Attachment < ActiveRecord::Base
  belongs_to Assignment
  belongs_to Course
end
