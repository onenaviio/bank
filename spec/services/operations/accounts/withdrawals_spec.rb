require "rails_helper"

RSpec.describe Operations::Accounts::Withdrawals, type: :service do
  subject(:service_call) { described_class.call(payload: payload, account: account) }

  let(:account) { create(:account, balance: balance) }
  let(:payload) { 750 }

  context "when balance more than payload" do
    let(:balance) { 1000 }

    it "decrements balance" do
      expect { service_call }.to(change { account.reload.balance }.from(balance).to(balance - payload))
    end
  end

  context "when balance less than payload" do
    let(:balance) { 200 }

    it "raises the error" do
      expect { service_call }.to raise_error(Operations::Errors::NegativeBalance)
    end

    # TODO: check that balance is not changed
  end
end
