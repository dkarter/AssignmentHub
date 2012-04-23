class Assignment < ActiveRecord::Base
  belongs_to :course

  before_create :schedule_notification
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"

  def schedule_notification()
    name = self.name
    due = self.due_date
    remind_time = due - 1.day
    #course = self.course
    #user = course.user.name
    #user = User.new(:name => "Bob", :password => "password", :first => "Bob", :last => "Bobber", :email => "nephanim@gmail.com")
    #email = "nephanim@gmail.com"
    #name = "Nephanim"
    #assignment = "Assignment"
    #course = "Test Course"
    #due = "tomorrow"
    #Notifications.deliver_notification(email, name, course, assignment, due)
    Notifications.send_at(remind_time, :deliver_notification,"nephanim@gmail.com", "Nephanim", "Test Course", name, due).deliver
  end

end
