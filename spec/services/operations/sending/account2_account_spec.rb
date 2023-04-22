require "rails_helper"

RSpec.describe Operations::Sending::Account2Account, type: :service do
  subject(:service_call) do
    described_class.call(account_from: account_from, account_to: account_to, payloads: payloads)
  end

  let(:account_from) { create(:account, balance: 5000, currency: account_from_currency) }
  let(:account_to) { create(:account, balance: 0, currency: account_to_currency) }
  let(:payloads) do
    Types::Commissions::Payload[{
      payload: 500.0,
      commission_payload: 50.0,
      payload_with_commission: 550.0
    }]
  end

  let!(:user_bank) { create(:user_bank) }

  context "when accounts currencies are different" do
    let(:account_from_currency) { :usd }
    let(:account_to_currency) { :rub }

    it "raises error" do
      expect { service_call }.to raise_error(Operations::Errors::WrongCurrency)
    end
  end

  context "when accounts currencies are same" do
    let(:account_from_currency) { :rub }
    let(:account_to_currency) { :rub }

    before do
      allow(Operations::Accounts::Withdrawals).to receive(:call)
      allow(Operations::Accounts::Replenishment).to receive(:call)
      allow(Operations::Bank::Receive).to receive(:call).and_yield(bank_history_operation)
      allow(HistoryOperations::Create).to receive(:call)
      service_call
    end

    context "when account_from" do
      it "calls decrease account from balance service" do
        expect(Operations::Accounts::Withdrawals).to have_received(:call)
          .with(account: account_from, payload: 550.0)
      end

      it "calls history_operations service" do
        expect(HistoryOperations::Create).to have_received(:call).once.with(
          account: account_from,
          payload: -550.0,
          title: HistoryOperationsConstants::SEND_MONEY_TITLE,
          operation_type: :transactions,
          options: {
            receiver_id: account_to.user_id,
            sender_id: account_from.user_id
          }
        )
      end
    end

    context "when account_to" do
      it "calls increase account to balance service" do
        expect(Operations::Accounts::Replenishment).to have_received(:call)
          .with(account: account_to, payload: 500.0)
      end

      it "calls history_operations service" do
        expect(HistoryOperations::Create).to have_received(:call).once.with(
          account: account_to,
          payload: 500.0,
          title: HistoryOperationsConstants::RECEIVE_MONEY_TITLE,
          operation_type: :transactions,
          options: {
            receiver_id: account_to.user_id,
            sender_id: account_from.user_id
          }
        )
      end
    end

    context "when bank account" do
      it "calls receive bank commission service" do
        expect(Operations::Bank::Receive).to have_received(:call)
          .with(payload: 50.0, currency: account_from.currency)
      end

      it "calls history_operations service" do
        # expect(HistoryOperations::Create).to have_received(:call).once.with(
        #   account: bank_account,
        #   payload: 500.0,
        #   title: HistoryOperationsConstants::RECEIVE_MONEY_TITLE,
        #   operation_type: :transactions,
        #   options: {
        #     receiver_id: account_to.user_id,
        #     sender_id: account_from.user_id
        #   }
        # )
      end
    end
  end

  # context "when no commission" do; end
  # context "when any error" do; end
end
