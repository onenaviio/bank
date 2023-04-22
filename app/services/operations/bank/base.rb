# :nocov:
class Operations::Bank::Base < AppService
  include Operations::Errors

  with_payload_option
  option :currency, Types::Currency

  private

  def bank_account
    @bank_account ||= begin
      bank_account = User.bank.accounts.find_by(currency: currency)
      return bank_account if bank_account.present?

      raise Operations::Errors::NoCurrencyAccount, currency
    end
  end
end
