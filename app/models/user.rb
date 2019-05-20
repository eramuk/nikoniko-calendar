class User < ApplicationRecord
  varidates :name, presence: true
  varidates :email, presence: true
end
