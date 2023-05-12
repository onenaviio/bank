class Transactions::Handler < AppService
  param :transaction, Types::Transaction

  def call
    raise NotImplementedError
  end

  private

  def account_from
    @account_from ||= transaction.account_from
  end

  def account_to
    @account_to ||= transaction.account_to
  end

  def card_from
    @card_from ||= transaction.card_from
  end

  def card_to
    @card_to ||= transaction.card_to
  end

  def commission_payload
    @commission_payload ||= transaction.commission_payload
  end

  def confirm_transaction!
    transaction.confirm!
  end

  def decrease_account_from_balance!
    payload = transaction.payload + commission_payload
    Operations::Accounts::Withdrawals.call(payload: payload, account: account_from)
  end

  def update_reached_limit!
    ReachedLimits::Updator.call(transaction)
  end

  def pay_commission!
    return if commission_payload.zero?

    Operations::Bank::Receive.call(payload: commission_payload, currency: account_from.currency)
  end
end
