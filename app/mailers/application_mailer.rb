class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{ENV.fetch("HOST") { "localhost" }}"
  layout 'mailer'
end
