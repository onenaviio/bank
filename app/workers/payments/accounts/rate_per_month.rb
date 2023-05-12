class Payments::Accounts::RatePerMonth < ApplicationWorker
  sidekiq_options queue: "payments"

  def perform
    accounts.find_each do |account|
      create_transaction(account)
    rescue StandardError => e
      Issues::Creator.call(e, account_id: account.id)
    end
  end

  private

  def accounts
    Account.includes(:service_rate).where.not(id: User.bank.account_ids)
  end

  def create_transaction(account)
    Transactions::Creator::ByAccount.call(
      account_from: account,
      account_to: account_to(account),
      operation_type: :rate_payment,
      payloads: Types::Commissions::Payload[payload: payload(account), commission_payload: 0.0],
      params: {
        comment: OperationsConstants::MONTH_RATE_PAYMENT
      }
    )
  end

  def account_to(account)
    User.bank.accounts.find_by!(currency: account.currency)
  end

  def payload(account)
    account.service_rate.service_per_month
  end
end
