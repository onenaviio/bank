class ReachedLimits::Index < AppService
  FIELDS = %i[
    withdrawals_to_commission
    c2c_external_to_commission
    c2c_internal_to_commission
    sbp_to_commission
  ].freeze

  param :user, Types::User

  delegate :reached_limit, :month_limit, to: :account

  def call
    accounts.map do |account|
      {
        account_id: account.id,
        **extract_account_limits(account)
      }
    end
  end

  private

  def extract_account_limits(account)
    FIELDS.each_with_object({}) do |field, object|
      object[field] = {
        month: account.month_limit.send(field),
        reached: account.reached_limit.send(field)
      }
    end
  end

  def accounts
    user.accounts.includes(:month_limit, :reached_limit)
  end
end
