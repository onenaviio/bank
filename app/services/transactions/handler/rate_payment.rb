class Transactions::Handler::RatePayment < Transactions::Handler
  def call
    ActiveRecord::Base.transaction do
      decrease_account_from_balance!
      increase_account_to_balance!

      confirm_transaction!
    end
  end

  private

  def decrease_account_from_balance!
    Operations::Accounts::Withdrawals.call(account: account_from, payload: transaction.payload, force: true)
  end

  def increase_account_to_balance!
    Operations::Accounts::Replenishment.call(account: account_to, payload: transaction.payload)
  end
end
