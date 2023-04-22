require "rails_helper"

RSpec.describe Operations::Commissions::Calculator, type: :service do
  subject(:service_call) { described_class.call(payload: payload, commission: commission) }

  let(:payload) { 500 }

  context "when commission type is value" do
    let(:commission) do
      Types::Cards::Commission[{
        value: 150.0,
        type: :value
      }]
    end

    let(:expected_result) do
      Types::Commissions::Payload[{
        payload: 500.0,
        commission_payload: 150.0,
        payload_with_commission: 650.0
      }]
    end

    it "returns correct commission object" do
      expect(service_call).to eq(expected_result)
    end
  end

  context "when commission type is percent" do
    let(:commission) do
      Types::Cards::Commission[{
        value: 2.5,
        type: :percent
      }]
    end

    let(:expected_result) do
      Types::Commissions::Payload[{
        payload: 500.0,
        commission_payload: 12.5,
        payload_with_commission: 512.5
      }]
    end

    it "returns correct commission object" do
      expect(service_call).to eq(expected_result)
    end
  end
end
