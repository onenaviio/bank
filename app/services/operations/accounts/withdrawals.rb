class Operations::Accounts::Withdrawals < Operations::Accounts::Base
  def call
    balance = account.balance - payload
    raise Operations::Errors::NegativeBalance if balance.negative?

    account.update!(balance: round(balance))
  end
end
