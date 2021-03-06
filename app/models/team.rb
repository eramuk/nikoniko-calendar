class Team < ApplicationRecord
  has_many :user_teams, dependent: :destroy
  has_many :users, through: :user_teams
  has_many :invitations, class_name: "TeamInvitation"

  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }, allow_nil: true

  def join(user_id, role)
    self.user_teams.create(user_id: user_id, role: role)
  end

  def leave(user_id)
    self.user_teams.find_by(user_id: user_id).destroy
  end

  def last_user?
    self.users.size == 1
  end

  def last_owner?
    self.users.where(user_teams: {role: :owner}).size == 1
  end
end
