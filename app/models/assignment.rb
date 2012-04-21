class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"

  def schedule_notification()
    course = self.course
    user = course.user.name
    assignment = self.name
    due = self.due_date
    NotificationMailer.send_at(due - 1.day, :deliver_notification, user, course, assignment, due)
  end

end
