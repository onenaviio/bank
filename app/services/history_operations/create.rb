class HistoryOperations::Create < AppService
  def initialize(account:, title:, payload:, operation_type:, card: nil, options: {})
    @account        = account
    @title          = title
    @payload        = payload.to_f
    @operation_type = operation_type
    @card           = card
    @options        = options
  end

  def call
    history_operation = account.history_operations.create!(
      card: card,
      title: title,
      payload: payload,
      operation_type: operation_type,
      processed_at: DateTime.current,
      options: options
    )

    history_operation
  end

  private

  attr_reader :account, :title, :payload, :operation_type, :card, :options
end
