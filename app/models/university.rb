class University < ActiveRecord::Base
  validates_presence_of :name, :city, :state, :website, :message => "must provide basic information"
  validates_length_of :name, :city, :state, :maximum => 15, :message => "less than 15 characters please"
end
