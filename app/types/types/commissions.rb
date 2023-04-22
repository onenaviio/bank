module Types::Commissions
  class Payload < Dry::Struct
    attribute :payload, Types::Float
    attribute :commission_payload, Types::Float
    attribute :payload_with_commission, Types::Float
  end
end
