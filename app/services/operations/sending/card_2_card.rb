class Operations::Sending::Card2Card < AppService
  include Operations::Errors

  def initialize(card_from:, card_to:, payload:, commission: 0)
    @card_from = card_from
    @card_to   = card_to

    payloads = Operations::Commissions::Calculator.call(payload: payload, commission: commission)

    @payload                 = payloads[:payload]
    @commission_payload      = payloads[:commission_payload]
    @payload_with_commission = payloads[:payload_with_commission]
  end

  def call
    ActiveRecord::Base.transaction do
      validate_accounts_currency!
      decrease_account_from_balance!
      increase_account_to_balance!
      increase_bank_account_balance! if with_commission?
    end
  end

  private

  attr_reader :card_from, :card_to, :payload, :commission_payload, :payload_with_commission

  def validate_accounts_currency!
    return if card_from.account.currency == card_to.account.currency

    raise Operations::Errors::WrongCurrency
  end

  def decrease_account_from_balance!
    Operations::Cards::Withdrawals.call(card: card_from, payload: payload_with_commission)
  end

  def increase_account_to_balance!
    Operations::Cards::Replenishment.call(card: card_to, payload: payload)
  end

  def increase_bank_account_balance!
    Operations::Bank::Receive.call(payload: commission_payload, currency: card_from.account.currency)
  end

  def with_commission?
    payload != payload_with_commission
  end
end
