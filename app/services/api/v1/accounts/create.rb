class Api::V1::Accounts::Create < AppService
  def initialize(user:, currency:)
    @user     = user
    @currency = currency
  end

  def call
    user.accounts.create!(number: number, currency: currency, service_rate: service_rate)
  end

  private

  attr_reader :user, :currency

  def number
    (0..6).map { rand(10_000..99_999) }.join
  end

  def service_rate
    ServiceRate.find_by(title: "Базовый")
  end
end
