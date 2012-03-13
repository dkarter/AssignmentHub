class Notifications < ActionMailer::Base
  default from: "support@assignmenthub.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.forgot_password.subject
  #
  def forgot_password(email, name, password)
    @greeting = "Hello"
    @name = name
    @password = password

    mail to: email
  end
end
