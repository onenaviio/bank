class HistoryOperations::Create < AppService
  option :account, Types::Account
  option :title, Types::StringOrSymbol
  option :payload, ->(value) { value.to_f }
  option :operation_type, Types::StringOrSymbol

  option :card, Types::Card, optional: true
  option :extra_data, default: -> { {} }

  def call
    account.history_operations.create!(
      title: title,
      payload: payload,
      operation_type: operation_type,
      processed_at: Time.zone.now,
      card: card,
      extra_data: extra_data
    )
  end
end
