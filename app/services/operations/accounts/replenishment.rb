class Operations::Accounts::Replenishment < Operations::Accounts::Base
  def call
    balance = account.balance + payload

    account.update!(balance: round(balance))
  end
end
