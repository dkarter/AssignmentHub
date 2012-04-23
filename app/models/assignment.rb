class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  scope :before, lambda {|end_time| {:conditions => ["due_date < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["start_date > ?", Event.format_date(start_time)] }}
  
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 15, :message => "less than 15 characters please"

  def schedule_notification()
    course = self.course
    user = course.user.name
    assignment = self.name
    due = self.due_date
    NotificationMailer.send_at(due - 1.day, :deliver_notification, user, course, assignment, due)
  end

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.name,
      :description => self.notes || "",
      :start => self.start_date.rfc822,
      :end => self.due_date.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.assignment_path(id)
    }
    
  end

end
