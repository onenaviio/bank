FactoryBot.define do
  factory :service_rate do
    title { Faker::Lorem.word }
    service_per_month { Faker::Number.between(from: 100, to: 200) }
    c2c_commission_type { :value }
    c2c_commission_value { Faker::Number.between(from: 100, to: 200) }

    ServiceRate.c2c_commission_types.each_key do |c2c_commission_type|
      trait c2c_commission_type do
        c2c_commission_type { c2c_commission_type }
      end
    end
  end
end
