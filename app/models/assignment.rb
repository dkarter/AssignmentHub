class Assignment < ActiveRecord::Base
  belongs_to :course

  def schedule_notification()
    course = self.course
    user = course.user.name
    assignment = self.name
    due = self.due_date
    NotificationMailer.send_at(due - 1.day, :deliver_notification, user, course, assignment, due)
  end

end