class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{ENV.fetch("MAIL_DOMAIN") { "localhost" }}"
  layout 'mailer'
end
