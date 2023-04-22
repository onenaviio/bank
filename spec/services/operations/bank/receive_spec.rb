require "rails_helper"

RSpec.describe Operations::Bank::Receive, type: :service do
  subject(:service_call) { described_class.call(payload: payload, currency: currency) }

  let!(:user_bank) { create(:user_bank) }

  let(:payload) { Faker::Number.number }
  let(:currency) { "rub" }

  context "when account with passed currency exists" do
    let!(:bank_account) { create(:account, currency: currency, user: user_bank) }

    it "increments accoutn balance" do
      expect { service_call }.to(change { bank_account.reload.balance }.by(payload))
    end
  end

  context "when account with passed currency doesn't exist" do
    it "raises error" do
      expect { service_call }.to raise_error(Operations::Errors::NoCurrencyAccount)
    end
  end
end
