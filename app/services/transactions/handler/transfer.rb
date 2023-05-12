class Transactions::Handler::Transfer < Transactions::Handler
  def call
    ActiveRecord::Base.transaction do
      decrease_account_from_balance!
      increase_account_to_balance!
      pay_commission!
      confirm_transaction!
      update_reached_limit!
    end
  end

  private

  def increase_account_to_balance!
    Operations::Accounts::Replenishment.call(payload: transaction.payload, account: account_to)
  end
end
