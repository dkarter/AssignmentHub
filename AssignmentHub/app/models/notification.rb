class Notifications < ActionMailer::Base
  belongs_to User
  
  #i believe this should be in controllers. Dorian
  def forgot_password(email, name, password)
    @subject = "Your new AssignmentHub password"
    @body['login'] = name
    @body['pass'] = password
    @recipients = email
    @from = "support@assignmenthub.com"
    @sent_on = Time.now
    @headers = {}
  end
end