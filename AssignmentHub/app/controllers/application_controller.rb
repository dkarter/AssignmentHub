#include ActionView::Helpers::RawOutputHelper
class ApplicationController < ActionController::Base
  protect_from_forgery


  private 
  helper_method :current_user

  private
  def current_user
    @current_user = User.where(:name => session[:name]) if session[:name]
  end
  
  private 
  helper_method :is_admin
  
  private
  def is_admin
    @is_admin = (current_user && User.find(current_user).user_type == 0) ? true : false
  end
  
  #fix ugly HTML for form errors  -Dorian
  #ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  #    raw %(<span class="field_with_errors">#{html_tag}</span>)
  #end
  
end
