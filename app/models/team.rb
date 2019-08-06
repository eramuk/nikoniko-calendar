class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :invitations, class_name: "TeamInvitation"

  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }, allow_nil: true

  def join(user_id)
    self.user_teams.create(user_id: user_id)
  end

  def leave(user_id)
    self.user_teams.find_by(user_id: user_id).destroy
  end

  def last_user?
    self.users.size == 1
  end
end
