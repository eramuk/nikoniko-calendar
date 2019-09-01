class UserTeam < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum role: {
    guest: 0,
    member: 1,
    owner: 2
  }

  validates :user_id, uniqueness: { scope: :team_id }
  validates :role, inclusion: { in: roles }

  before_validation do
    if self.team && self.team.users.empty?
      self.role = :owner
    end
  end
end
