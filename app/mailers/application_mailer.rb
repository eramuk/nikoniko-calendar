class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{ENV.fetch("DOMAIN") { "localhost" }}"
  layout 'mailer'
end
