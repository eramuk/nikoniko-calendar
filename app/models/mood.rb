class Mood < ApplicationRecord
  module Score
    GOOD = 1
    NORMAL = 2
    BAD = 3
  end

  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :score, presence: true, inclusion: { in: Score::GOOD..Score::BAD }

  scope :recent_week, -> (num) { where(date: (num.week.ago + 1.day)..Time.current) }
end
