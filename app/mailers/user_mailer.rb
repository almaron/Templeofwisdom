class UserMailer < ActionMailer::Base
  default from: "noreply@templeofwisdom.ru"

  def activation_needed_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('mail.user_mailer.activation_needed.subject'))
  end

  def activation_success_email(user)

  end

  def reset_password_email(user)

  end

end
