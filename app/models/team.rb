class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams

  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }, allow_nil: true
end
