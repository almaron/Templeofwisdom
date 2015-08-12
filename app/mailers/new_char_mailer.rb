class NewCharMailer < ActionMailer::Base
  default from: 'noreply@templeofwisdom.ru'

  def new_char(char)
    @char = char
    mail to: admins, subject: default_i18n_subject(name: @char.name)
  end

  private

  def admins
    [
      'Gerda <miledy2003@gmail.com>',
      'RougeFler <RougeFler@mail.ru>',
      'Almaron <almaron@gmail.com>'
    ]
  end
end
