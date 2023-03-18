class Operations::Bank::Receive < Operations::Bank::Base
  def call
    Operations::Accounts::Replenishment.call(account: bank_account, payload: payload)
  end
end
