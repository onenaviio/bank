class Transactions::Handler::Replenishment < Transactions::Handler::Base
  def call
    ActiveRecord::Base.transaction do
      Operations::Accounts::Replenishment.call(account: account_to, payload: transaction.payload)
      confirm_transaction!
    end
  end
end
