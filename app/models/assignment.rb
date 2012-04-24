# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#AssignmentHub - My School Organizer on the Cloud
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#Copyright (C) 2012 Dorian Karter, Joseph Low, Amar Rana
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
#documentation files (the "Software"), to deal in the Software without restriction, including without limitation
#the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
#to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions
#of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
#TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
#CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#DEALINGS IN THE SOFTWARE.
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  
  before_create :schedule_notification
  
  scope :before, lambda {|end_time| {:conditions => ["due_date < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["start_date > ?", Event.format_date(start_time)] }}
  
  validates_presence_of :name, :message => "must provide basic information"
  validates_length_of :name, :maximum => 50, :message => "less than 50 characters please"

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
    if notify == '{"Notification Type"=>"1W"}'
      remind_time = due - 1.week
      Notifications.delay(:run_at => remind_time).deliver_notification(email, owner, course_name, name, due)
    elsif notify == '{"Notification Type"=>"1H"}'
      remind_time = due - 1.hour
      Notifications.delay(:run_at => remind_time).deliver_notification(email, owner, course_name, name, due)
    elsif notify == '{"Notification Type"=>"24H"}'
      remind_time = due - 1.day
      Notifications.delay(:run_at => remind_time).deliver_notification(email, owner, course_name, name, due)
    else
      #Do nothing - the user chose not to be reminded or an unrecognized type was found
    end
  end

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.name,
      :start => self.start_date,
      :end => self.due_date,
      :allDay => self.all_day,
      :recurring => false,
      :color => (self.course ? '#' + self.course.color : ''),
      :url => Rails.application.routes.url_helpers.assignment_path(id)
      
    }
    
  end
  
  ASSIGNMENTTYPE = [['Midterm Exam', '0'],
                    ['Final Exam', '1'],
                    ['Paper', '2'],
                    ['Project Deliverable', '3'],
                    ['Final Project', '4'],
                    ['Lab','5']]
  
  def self.GetAssignmentTypeFromValue(value)
    temp = ASSIGNMENTTYPE.select{ |x| x[1] == value.to_s() }.first
    return temp ? temp.first : ''
  end

end
