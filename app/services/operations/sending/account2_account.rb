class Operations::Sending::Account2Account < AppService
  include HistoryOperationsConstants
  include Operations::Errors

  option :account_from, Types::Account
  option :account_to, Types::Account
  option :payloads, Types::Commissions::Payload

  def call
    validate_accounts_currency!
    ActiveRecord::Base.transaction do
      decrease_account_from_balance!
      increase_account_to_balance!
      increase_bank_account_balance! if with_commission?
    end
  end

  private

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
    history_operations_create!(account_to, payload: payload, title: RECEIVE_MONEY_TITLE)
  end

  def increase_bank_account_balance!
    options = { payload: commission_payload, currency: account_from.currency }

    Operations::Bank::Receive.call(options) do |bank_account:, payload:|
      history_operations_create!(bank_account, payload: payload, title: TRANSACTION_COMMISSION)
    end
  end

  def history_operations_create!(account, payload:, title:)
    HistoryOperations::Create.call(
      account: account,
      payload: payload,
      title: title,
      operation_type: :transactions,
      extra_data: {
        receiver_id: account_to.user_id,
        sender_id: account_from.user_id
      }
    )
  end

  def payload
    payloads.payload
  end

  def commission_payload
    payloads.commission_payload
  end

  def payload_with_commission
    payloads.payload_with_commission
  end

  def with_commission?
    payload != payload_with_commission
  end
end
