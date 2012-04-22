class Assignment < ActiveRecord::Base
  belongs_to :course
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"

  def schedule_notification()
    @assignment = self
    #course = self.course
    #user = course.user.name
    #user = User.new(:name => "Bob", :password => "password", :first => "Bob", :last => "Bobber", :email => "nephanim@gmail.com")
    #email = "nephanim@gmail.com"
    #name = "Nephanim"
    #assignment = "Assignment"
    #course = "Test Course"
    #due = "tomorrow"
    #Notifications.deliver_notification(email, name, course, assignment, due)
    Notifications.deliver_notification("nephanim@gmail.com", "Nephanim", "Test Course", "Test Assignment", "tomorrow").deliver
  end

end
