class Api::V1::Accounts::Create < AppService
  def initialize(user:, currency:)
    @user     = user
    @currency = currency
  end

  def call
    account = user.accounts.create!(number: number, currency: currency)

    account
  end

  private

  attr_reader :user, :currency

  def number
    (0..6).map { rand(10000..99999) }.join("")
  end
end
