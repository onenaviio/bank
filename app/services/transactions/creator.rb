class Transactions::Creator < AppService
  option :external_account_to_id, optional: true
  option :external_account_to_type, optional: true

  option :operation_type
  option :payloads, Types::Commissions::Payload
  option :status, default: -> { :unconfirmed }

  option :extra_data, default: -> { {} }
  option :params, {} do
    option :comment, optional: true
  end

  option :perform, default: -> { true }

  def call
    return if payloads.payload.zero?

    transaction = create_transaction!
    pefrorm_transaction(transaction) if perform
    transaction
  end

  private

  def card_from
    raise NotImplementedError
  end

  def card_to
    raise NotImplementedError
  end

  def account_form
    raise NotImplementedError
  end

  def account_to
    raise NotImplementedError
  end

  def transaction_by
    raise NotImplementedError
  end

  def create_transaction!
    Transaction.create!(
      **main_attributes,
      **relation_attributes,
      extra_data: {
        transaction_by: transaction_by,
        **extra_data
      }
    )
  end

  def main_attributes
    {
      operation_type: operation_type,
      payload: payloads.payload,
      commission_payload: payloads.commission_payload,
      comment: params.comment,
      status: status,
      started_at: DateTime.now.in_time_zone,
      suspicious: suspicious_operation?
    }
  end

  def relation_attributes
    {
      account_from: account_from,
      account_to: account_to,
      card_from: card_from,
      card_to: card_to,
      external_account_to_id: external_account_to_id,
      external_account_to_type: external_account_to_type
    }
  end

  def pefrorm_transaction(transaction)
    if suspicious_operation?
      Transactions::SuspiciousOperationWorker.perform_async(transaction.id)
    else
      Transactions::OperationWorker.perform_async(transaction.id)
    end
  end

  def suspicious_operation?
    payloads.payload >= 1_000_000.0 && operation_type == "transfer"
  end
end
