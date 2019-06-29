require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let(:calendar) { build(:calendar) }

  it { expect(calendar).to be_valid }

  it "not to be valid with blank attribute" do
    calendar.user_id = nil
    expect(calendar).not_to be_valid

    calendar.date = nil
    expect(calendar).not_to be_valid

    calendar.mood = nil
    expect(calendar).not_to be_valid
  end

  it "not to be valid when mood is over" do
    calendar.mood = Calendar::Mood::BAD + 1
    expect(calendar).not_to be_valid
  end
end
