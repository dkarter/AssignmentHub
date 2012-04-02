require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save user without vital properties" do
    user = User.new
    assert !user.save, "Saved user without a name, password, first, last, email, user type"
  end

  test "should not allow short names" do
    user = User.new(:name => 'ts', :password => 'password', :first => 'first', :last => 'last', :email => 'test@test.com', :user_type => 0)
    assert !user.save, "Saved user with too short name"
  end

  test "should not allow short password" do
    user = User.new(:name => 'tester', :password => 'pass', :first => 'first', :last => 'last', :email => 'test@test.com', :user_type => 0)
    assert !user.save, "Saved user with too short password"
  end

  test "should not allow bad email format" do
    user = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figsandpickles', :user_type => 0)
    assert !user.save, "Saved user with invalid email format"
  end

  test "should not allow duplicate user names" do
    user = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figsandpickles', :user_type => 0)
    user.save
    user2 = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figsandpickles', :user_type => 0)
    assert !user2.save, "Saved user with duplicate name"
  end
end
