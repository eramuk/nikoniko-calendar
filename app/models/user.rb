class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  module Password
    MIN_LENGTH = 8
  end

  has_many :moods, dependent: :destroy

  before_create :create_activation_digest

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: Password::MIN_LENGTH }, allow_nil: true
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def calendars
    recent_moods = moods.recent_week(2)
    calendar = Calendar::week(2)

    calendar.each do |day|
      match = false
      recent_moods.each do |mood|
        if mood.date == day[:date]
          match = true
          break
        end
      end
      unless match
        recent_moods += [moods.build(date: day[:date])]
      end
    end

    [{user_name: self.name, calendar: recent_moods.sort_by{|x| x[:date]}}]
  end

  def today_mood
    today_mood = moods.today
    today_mood.blank? ? moods.build(date: Time.current) : today_mood.first
  end

  private

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
