require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :courses

  # Validation of various parameters. Important: require valid email format, unique username

  before_create :encrypt_password
  before_update :encrypt_password

  validates_length_of :name, :within => 3..15
  validates_length_of :password, :within => 5..40
  validates_presence_of :name, :password, :first, :last, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_uniqueness_of :name, :email
  validates_confirmation_of :password

  USERTYPE = [['Normal', '1'],
              ['Admin', '0']]


  def self.authenticate(name, pass)
    user = find_by_name(name)
    if user && User.encrypt(pass, user.pass_salt) == user.password
      user
    else
      nil
    end
  end

  def check_password(pass)
    self.password == Digest::SHA1.hexdigest(pass+self.pass_salt)
  end

  def encrypt_password()
    self.pass_salt = User.random_string(10) if !self.pass_salt
    self.password = self.password_confirmation = User.encrypt(self.password, self.pass_salt)
  end

  def encrypt_given_password(password)
    if !self.pass_salt
      self.pass_salt = User.random_string(10)
    end
    self.password = password
    self.password = self.password_confirmation = User.encrypt(password, self.pass_salt)
  end

  def forgot_password(name, email)
    user = User.find_by_name(name)
    if user.email == email
      new_pass = User.random_string(10)
      user.encrypt_given_password(new_pass)
      user.save
      Notifications.forgot_password(self.email, self.name, new_pass).deliver
    end
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
