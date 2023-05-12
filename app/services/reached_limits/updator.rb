class ReachedLimits::Updator < AppService
  param :transaction, Types::Transaction

  def call
    attributes = current_limit_values.each_with_object({}) do |(field, current_value), obj|
      next unless field.in?(limit_fields)

      incremented_value = current_value + transaction.payload
      limit_value = month_limit.send(field)

      obj[field] = [incremented_value, limit_value].min
    end

    account_from.reached_limit.update!(attributes)
  end

  private

  def current_limit_values
    @current_limit_values ||= account_from.reached_limit.as_json.except("id", "service_rate_id")
  end

  def limit_fields
    case transaction.operation_type
    when "transfer"
      transfer_limit_fields
    when "withdrawals"
      %w[withdrawals_to_commission]
    end
  end

  def transfer_limit_fields
    case transaction.extra_data["transaction_by"]
    when "card"
      transaction.external? ? %w[c2c_external_to_commission] : %w[c2c_internal_to_commission]
    when "sbp"
      %w[sbp_to_commission]
    when "account"
      []
    end
  end

  def account_from
    @account_from ||= transaction.account_from
  end

  def month_limit
    @month_limit ||= account_from.month_limit
  end
end
