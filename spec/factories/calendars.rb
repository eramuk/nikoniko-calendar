FactoryBot.define do
  factory :calendar do
    date { "2019-06-29 13:30" }
    mood { 1 }

    user { FactoryBot.create(:user) }
  end
end
