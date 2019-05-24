FactoryBot.define do
  factory :user do
    name { "alice" }
    email { "alice@example.com" }
    password { "alice123" }
    password_confirmation { "alice123" }
  end
end
