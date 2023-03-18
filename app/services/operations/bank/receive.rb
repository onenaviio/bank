class Operations::Bank::Receive < AppService
  include Operations::Errors

  def initialize(payload:, currency:)
    @payload  = payload.to_f
    @currency = currency
  end

  def call
    Operations::Accounts::Replenishment.call(account: bank_account, payload: payload)
  end

  private

  attr_reader :payload, :currency

  def bank_account
    bank_account = User.bank.accounts.find_by(currency: currency)
    return bank_account if bank_account.present?

    raise Operations::Errors::NoCurrencyAccount, currency
  end
end
