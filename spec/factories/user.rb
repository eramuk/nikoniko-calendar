FactoryBot.define do
  factory :user do
    name { "alice" }
    email { "alice@example.com" }
    password { "alice" }
    password_confirmation { "alice" }
  end
end
