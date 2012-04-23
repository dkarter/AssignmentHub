class Assignment < ActiveRecord::Base
  belongs_to :course

  before_create :schedule_notification
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"

  def schedule_notification()
    @course = Course.find(self.course_id)
    course_name = @course.name
    @user = @course.user
    name = self.name
    owner = @user.name
    email = @user.email
    due = self.due_date
    notify = self.notification_type

    #See what kind of notification type the user selected
    if notify == '1W'
      remind_time = due - 1.week
      Notifications.delay(:run_at => remind_time).deliver_notification(email, owner, course_name, name, due)
    elsif notify == '1H'
      remind_time = due - 1.hour
      Notifications.delay(:run_at => remind_time).deliver_notification(email, owner, course_name, name, due)
    elsif notify == '24H'
      remind_time = due - 1.day
      Notifications.delay(:run_at => remind_time).deliver_notification(email, owner, course_name, name, due)
    else
      #Do nothing - the user chose not to be reminded or an unrecognized type was found
    end
  end

end
