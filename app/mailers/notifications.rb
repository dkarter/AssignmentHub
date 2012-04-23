class Notifications < ActionMailer::Base
  default from: "support@assignmenthub.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.forgot_password.subject

  # See notifications/forgot_password.text.erb

  def forgot_password(email, name, password)
    @greeting = "Hello"
    @name = name
    @password = password

    mail to: email
  end

  # See notifications/deliver_notification.text.erb

  def deliver_notification(email, name, course, assignment, due)
    @greeting = "Hello"
    @name = name
    @coursename = course
    @assignment = assignment
    @due_date = due

    mail to: email
  end
end
