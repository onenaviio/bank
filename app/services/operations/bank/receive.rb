class Operations::Bank::Receive < Operations::Bank::Base
  def call
    Operations::Accounts::Replenishment.call(account: bank_account, payload: payload)
    yield(bank_account: bank_account, payload: payload) if block_given?
  end
end
