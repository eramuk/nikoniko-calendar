class UserTeam < ApplicationRecord
  belongs_to :user
  belongs_to :team

  before_save { self.admin = true }
  validates :user_id, uniqueness: { scope: :team_id }
end
