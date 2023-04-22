FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    patronymic { Faker::Name.middle_name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.unique.email }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 40) }
    password { Faker::Lorem.word }
  end

  factory :user_bank, class: "User" do
    first_name { "K.O. Bank" }
    last_name { "*"  }
    patronymic { "*" }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.unique.email }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 40) }
    password { Faker::Lorem.word }

    after(:create) do |user|
      Account.currencies.each_key do |currency|
        create(:account, currency, user: user)
      end
    end
  end
end
