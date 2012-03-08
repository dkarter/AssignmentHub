class Notifications < ActionMailer::Base
  belongs_to User
  
  #i believe this should be in controllers
  def forgot_password(email, name, password, sent_at = Time.now)
    @subject = "Your new AssignmentHub password"
    @body['login'] = name
    @body['pass'] = password
    @recipients = email
    @from = "support@assignmenthub.com"
    @sent_on = sent_at
    @headers = {}
  end
end