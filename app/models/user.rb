class User < ApplicationRecord
  has_secure_password

  PASSWORD_MIN_LENGTH = 8

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: PASSWORD_MIN_LENGTH }
end
