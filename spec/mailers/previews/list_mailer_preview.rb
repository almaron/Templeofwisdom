# Preview all emails at http://localhost:3000/rails/mailers/list_mailer
class ListMailerPreview < ActionMailer::Preview
  def mailing
    ListMailer.mailing(MailingLetter.find(1),User.find(1))
  end
end
