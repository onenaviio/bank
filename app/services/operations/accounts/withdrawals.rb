class Operations::Accounts::Withdrawals < Operations::Accounts::Base
  option :force, default: -> { false }

  def call
    balance = account.balance - payload
    return update_balance!(balance) if force
    raise Operations::Errors::NegativeBalance if balance.negative?

    update_balance!(balance)
  end

  private

  def update_balance!(balance)
    account.update!(balance: round(balance))
  end
end
