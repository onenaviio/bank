class Transactions::Handler::Withdrawals < Transactions::Handler
  def call
    ActiveRecord::Base.transaction do
      decrease_account_from_balance!
      pay_commission!
      confirm_transaction!
      update_reached_limit!
    end
  end
end
