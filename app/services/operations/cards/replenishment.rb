class Operations::Cards::Replenishment < Operations::Cards::Base
  def call
    balance = account.balance + payload

    account.update!(balance: balance)
  end
end
