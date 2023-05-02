class Operations::Sender < ApplicationService
  include Operations::Errors

  option :card_from, Types::Card
  option :card_to, Types::Card
  option :payloads, Types::Commissions::Payload

  option :params, {} do
    option :comment, default: -> {}
  end

  def call
    validate_accounts_currency!

    ActiveRecord::Base.transaction do
      transaction = create_transaction!
    end
  end

  private

  def validate_accounts_currency!
    return if account_from.currency == account_to.currency

    raise Operations::Errors::WrongCurrency
  end

  def create_transaction!
    Transaction.create!(
      account_from: account_from,
      account_to: account_to,
      card_from: card_from,
      card_to: card_to,
      payload: payload,
      commission_payload: commission_payload,
      operation_type: :transfer,
      status: :unconfirmed,
      comment: params.comment,
      processed_at: DateTime.now.in_time_zone
    )
  end

  def payload
    payloads.payload
  end

  def commission_payload
    payloads.commission_payload
  end

  def account_from
    @account_from ||= card_from.account
  end

  def account_to
    @account_to ||= card_to.account
  end
end
