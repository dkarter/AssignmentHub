require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should successfully save a new course" do
    course = Course.new(:name => 'Intro to VLSI', :course_number => 'ECE429', :school => 'Illinois Institute of Technology', :section => '1')
    assert course.save, "Failed to save user"
  end

end
