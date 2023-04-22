require "rails_helper"

RSpec.describe Operations::Accounts::Replenishment, type: :service do
  subject(:service_call) { described_class.call(payload: payload, account: account) }

  let(:account) { create(:account) }
  let(:payload) { Faker::Number.between(from: 500, to: 1000) }

  it "updates account balance" do
    expect { service_call }.to(change { account.reload.balance }.by(payload.abs))
  end

  context "when payload is float" do
    let(:payload) { 250.345 }

    it "updates account balance" do
      expect { service_call }.to(change { account.reload.balance }.by(250.35))
    end
  end
end
