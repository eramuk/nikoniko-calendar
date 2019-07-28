class TeamInvitation < ApplicationRecord
  before_create :create_activation_digest
  validates :team_id, presence: true
  validates :sender_user_id, presence: true
  validates :recipient_user_id, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def create_activation_digest
  end
end
