class Calendar < ApplicationRecord
  module Mood
    GOOD = 1
    NORMAL = 2
    BAD = 3
  end

  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :mood, presence: true, inclusion: { in: Mood::GOOD..Mood::BAD }
end
