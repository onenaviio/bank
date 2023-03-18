class Operations::Cards::Withdrawals < Operations::Cards::Base
  def call
    balance = account.balance - payload
    raise Operations::Errors::NegativeBalance if balance.negative?

    account.update!(balance: balance)
  end
end
