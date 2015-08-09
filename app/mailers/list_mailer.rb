class ListMailer < ActionMailer::Base
  default from: 'Храм Мудрости - Рассылка <mailer@templeofwisdom.ru>'

  def mailing(mailing, user)
    @mailing = mailing
    mail to: user.email, subject: @mailing.subject
  end
end
