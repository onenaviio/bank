class Operations::Bank::Base < AppService
  include Operations::Errors

  def initialize(payload:, currency:)
    @payload  = payload.to_f
    @currency = currency
  end

  private

  attr_reader :payload, :currency

  def bank_account
    @bank_account ||= begin
      bank_account = User.bank.accounts.find_by(currency: currency)
      return bank_account if bank_account.present?

      raise Operations::Errors::NoCurrencyAccount, currency
    end
  end
end
