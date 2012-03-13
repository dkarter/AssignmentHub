class Attachment < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :course
end
