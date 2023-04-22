class Api::V1::Accounts::Create < AppService
  option :user, Types::User
  option :currency, Types::Currency

  option :service_rate, default: -> { ServiceRate.find_by(title: "Базовый") }

  def call
    user.accounts.create!(number: number, currency: currency, service_rate: service_rate)
  end

  private

  def number
    (0..6).map { rand(10_000..99_999) }.join
  end
end
