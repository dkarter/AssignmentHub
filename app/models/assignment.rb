class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  scope :before, lambda {|end_time| {:conditions => ["due_date < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["start_date > ?", Event.format_date(start_time)] }}
  
  
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

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.name,
      :description => self.notes || "",
      :start => self.start_date,
      :end => self.due_date,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.assignment_path(id)
    }
    
  end
  
  ASSIGNMENTTYPE = [['Midterm Exam', '0'],
                    ['Final Exam', '1'],
                    ['Paper', '2'],
                    ['Project Deliverable', '3'],
                    ['Final Project', '4'],
                    ['Lab','5']]

end
