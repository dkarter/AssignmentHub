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

class Teacher < ActiveRecord::Base
  has_and_belongs_to_many :courses
  
  validates_presence_of :first, :last
  validates_length_of :first, :last, :maximum => 15, :message => "less than 15 characters please"
  validates_length_of :email, :maximum => 40, :message => "less than 40 characters please"
  validates_length_of :office_hours, :maximum => 50, :message => "less than 50 characters please"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  
  # i wouldn't do that.. what if two users create the same professor record?
  # we need to make the record belong to user
  #validates_uniqueness_of :email
  
  
  
  TITLETYPE = [['Prof.', '4'],
  ['Dr.', '3'],
  ['Mrs.', '2'],
  ['Ms.', '1'],
  ['Mr.', '0']]

  
  has_attached_file :photo, 
                    :default_url => "/assets/NA_:style.jpg", 
                    :styles => {:large => "300x300>", 
                                :small => "150x150>", 
                                :thumb => "57x75#"}
                                                  
  
  
  def self.GetTitleFromValue(value)
    temp = TITLETYPE.select{ |x| x[1] == value.to_s() }.first
    return temp ? temp.first : ''
  end
  
  def self.GetInstructorFullName(instructor)
    return "" if !instructor
      
    title_str = instructor.title ? GetTitleFromValue(instructor.title) + " " : ""
    return title_str + instructor.last + ", " + instructor.first
  end
end
