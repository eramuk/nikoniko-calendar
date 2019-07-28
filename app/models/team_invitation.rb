class TeamInvitation < ApplicationRecord
  attr_accessor :activation_token

  before_create :create_activation_digest
  validates :team_id, presence: true
  validates :sender_user_id, presence: true
  validates :recipient_user_id, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def TeamInvitation.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def TeamInvitation.new_token
    SecureRandom.urlsafe_base64
  end

  private

  def create_activation_digest
    self.activation_token  = TeamInvitation.new_token
    self.activation_digest = TeamInvitation.digest(activation_token)
  end
end
