class Api::V1::Accounts::Create < AppService
  option :user, Types::User
  option :currency, Types::Currency

  option :service_rate, default: -> { ServiceRate.find_by(title: "Базовый") }

  def call
    account = user.accounts.create!(number: number, currency: currency, service_rate: service_rate)
    create_reached_limit!(account)
    account
  end

  private

  def create_reached_limit!(account)
    account.build_reached_limit.save
  end

  def number
    (0..6).map { rand(10_000..99_999) }.join
  end
end
