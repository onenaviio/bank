module Types::HistoryOperations
  class TypedExtraData < Dry::Struct
    attribute :sender_id, Types::Integer.optional.default(nil)
    attribute :receiver_id, Types::Integer.optional.default(nil)
  end
end
