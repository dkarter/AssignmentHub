require 'digest/sha1'

class User < ActiveRecord::Base
  # Validation of various parameters. Important: require valid email format, unique username

  before_save :encrypt_password

  validates_length_of :name, :within => 3..15
  validates_length_of :password, :within => 5..40
  validates_presence_of :name, :password, :first, :last, :email, :user_type
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_uniqueness_of :name

  def self.authenticate(name, pass)
    user = find_by_name(name)
    if User.encrypt(pass, user.pass_salt) == user.password
      user
    else
      nil
    end
  end

  def check_password(pass)
    self.password == Digest::MD5.hexdigest(self.pass_salt)
  end

  def encrypt_password()
    self.pass_salt = User.random_string(10) if !self.pass_salt
    self.password = User.encrypt(self.password, self.pass_salt)
  end

  def forgot_password
    new_pass = User.random_string(10)
    self.password = User.encrypt(new_pass, user.pass_salt)
    self.save
    Notifications.mail_password(self.email, self.name, new_pass)
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(length)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    new_pass = ""
    1.upto(length) { |i| new_pass << chars[rand(chars.size-1)] }
    return new_pass
  end
end
