class Mood < ApplicationRecord
  belongs_to :user

  enum score: {
    good: 1,
    normal: 2,
    bad: 3
  }

  validates :user_id, presence: true, uniqueness: { scope: :date }
  validates :date, presence: true
  validates :score, presence: true, inclusion: { in: scores }

  scope :today, -> { where(date: Time.current) }
  scope :recent_week, -> (num) { where(date: (num.week.ago + 1.day)..Time.current) }

  def self.image_path(score)
    "mood_#{score.to_s}.png"
  end
end
