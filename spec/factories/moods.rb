FactoryBot.define do
  factory :mood do
    date { "2019-06-29 13:30" }
    score { 1 }

    user { FactoryBot.create(:user) }
  end
end
