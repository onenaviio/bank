module Types::Commissions
  class Payload < Dry::Struct
    attribute :payload, Types::Float
    attribute :commission_payload, Types::Float
  end
end
