class Mood < ApplicationRecord
  module Score
    GOOD = 1
    NORMAL = 2
    BAD = 3

    def self.list
      [GOOD, NORMAL, BAD]
    end

    def self.image_path(score)
      ["mood_good.png", "mood_normal.png", "mood_bad.png"][score - 1]
    end
  end

  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :score, presence: true, inclusion: { in: Score::list }

  scope :recent_week, -> (num) { where(date: (num.week.ago + 1.day)..Time.current) }
end
