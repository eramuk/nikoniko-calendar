require 'rails_helper'

RSpec.describe Mood, type: :model do
  let(:mood) { build(:mood) }

  it { expect(mood).to be_valid }

  it "not to be valid with blank attribute" do
    mood.user_id = nil
    expect(mood).not_to be_valid

    mood.date = nil
    expect(mood).not_to be_valid

    mood.score = nil
    expect(mood).not_to be_valid
  end

  it "not to be valid when mood is over" do
    mood.score = Mood.scores.values.last + 1
    expect(mood).not_to be_valid
  end
end
