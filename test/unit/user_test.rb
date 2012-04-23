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

  test "should validate password on login" do
    user = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figs@pickles.com', :user_type => 0)
    assert user.save, "Couldn't save user with normal properties"
    assert user.check_password('password'), "Couldn't validate password"
  end

   test "should authenticate with user name and password" do
    user = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figs@pickles.com', :user_type => 0)
    assert user.save, "Couldn't save user with normal properties"
    assert User.authenticate('tester','password'), "Couldn't log in"
   end

  test "should be able to encrypt a given password" do
    @user = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figs@pickles.com', :user_type => 0)
    @user.save
    assert User.authenticate('tester','password'), "Couldn't log in with original password"
    @user.encrypt_given_password('newpass')
    assert @user.save, "Couldn't save user with new password"
    assert @user.check_password('newpass'), "Encryption check failed"
    assert !User.authenticate('tester','password'), "Authenticated with wrong password! (old)"
    assert User.authenticate('tester','newpass'), "Couldn't log in"
  end

  test "should generate a new, working password" do
    user = User.new(:name => 'tester', :password => 'password', :first => 'first', :last => 'last', :email => 'figs@pickles.com', :user_type => 0)
    user.save
    assert user = User.find_by_name(user.name), "Couldn't find the user by name"
    assert user.email == 'figs@pickles.com', "Email doesn't match for user"
    assert new_pass = User.random_string(10), "Couldn't create new password"
    user.encrypt_given_password(new_pass)
    assert user.save, "Couldn't save user with new password"
    assert User.authenticate('tester',new_pass), "New password doesn't match"
    user.forgot_password('tester','figs@pickles.com')
    assert !user.check_password('password'), "Authenticated with wrong password! (old)"
  end
end
