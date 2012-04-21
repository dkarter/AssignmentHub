class Assignment < ActiveRecord::Base
  belongs_to :course
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"

  def schedule_notification()
    course = self.course
    #user = course.user.name
    if course
      user = User.new(:name => "Bob", :password => "password", :first => "Bob", :last => "Bobber", :email => "nephanim@gmail.com")
      assignment = self.name
      due = self.due_date - 1.days
      Notifications.delay.deliver_notification(user.email, user.name, course.name, assignment.name, due)
    end
  end

end
