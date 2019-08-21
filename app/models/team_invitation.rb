class TeamInvitation < ApplicationRecord
  attr_accessor :activation_token

  belongs_to :team
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :team_id, presence: true
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true
  validates :token, presence: true, uniqueness: true

  before_validation :create_token

  def create_token
    self.token = SecureRandom.hex(20)
  end
end
