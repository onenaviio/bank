FactoryBot.define do
  factory :account do
    user
    service_rate

    number { Faker::Number.unique.number }
    currency { :rub }
    balance { 0 }

    Account.currencies.each_key do |currency|
      trait currency do
        currency { currency }
      end
    end
  end
end
