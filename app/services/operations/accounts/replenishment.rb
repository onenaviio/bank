class Operations::Accounts::Replenishment < Operations::Accounts::Base
  def call
    balance = account.balance + payload

    account.update!(balance: balance)    
  end
end
