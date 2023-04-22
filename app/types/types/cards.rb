module Types::Cards
  class Commission < Dry::Struct
    attribute :value, Types::Float
    attribute :type, Types::Symbol
  end
end
