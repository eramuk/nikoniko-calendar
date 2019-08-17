class UserTeam < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum role: {
    viewer: 0,
    editor: 1,
    owner: 2
  }

  validates :user_id, uniqueness: { scope: :team_id }
  validates :role, inclusion: { in: roles }
end
