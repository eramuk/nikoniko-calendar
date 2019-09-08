class TeamInvitation < ApplicationRecord
  attr_accessor :activation_token

  belongs_to :team
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  before_validation :create_token

  validates :team_id, presence: true
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true
  validates :token, presence: true, uniqueness: true
  validate :sender_role

  def create_token
    self.token = SecureRandom.hex(20)
  end

  def sender_role
    sender_role = UserTeam.find_by(team_id: team_id, user_id: sender_id).role_before_type_cast
    if self.role > sender_role
      errors.add(:role, "is unauthorized")
    end
  end
end
