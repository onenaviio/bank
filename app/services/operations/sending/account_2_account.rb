class Operations::Sending::Account2Account < AppService
  include HistoryOperationsConstants
  include Operations::Errors

  def initialize(account_from:, account_to:, payloads:)
    @account_from = account_from
    @account_to   = account_to

    @payload                 = payloads[:payload]
    @commission_payload      = payloads[:commission_payload]
    @payload_with_commission = payloads[:payload_with_commission]
  end

  def call
    validate_accounts_currency!
    ActiveRecord::Base.transaction do
      decrease_account_from_balance!
      increase_account_to_balance!
      increase_bank_account_balance! if with_commission?
    end
  end

  private

  attr_reader :account_from, :account_to, :payload, :commission_payload, :payload_with_commission

  def validate_accounts_currency!
    return if account_from.currency == account_to.currency

    raise Operations::Errors::WrongCurrency
  end

  def decrease_account_from_balance!
    Operations::Accounts::Withdrawals.call(account: account_from, payload: payload_with_commission)
    history_operations_create!(account_from, payload: -payload_with_commission, title: SEND_MONEY_TITLE)
  end

  def increase_account_to_balance!
    Operations::Accounts::Replenishment.call(account: account_to, payload: payload)
    history_operations_create!(
      account_to,
      payload: payload,
      title: RECEIVE_MONEY_TITLE,
      options: {
        sender_id: account_from.user_id
      }
    )
  end

  def increase_bank_account_balance!
    Operations::Bank::Receive.call(payload: commission_payload, currency: account_from.currency)
  end

  def history_operations_create!(account, payload:, title:, options: {})
    HistoryOperations::Create.call(
      account: account,
      payload: payload,
      title: title,
      operation_type: :transactions,
      options: options
    )
  end

  def with_commission?
    payload != payload_with_commission
  end
end
