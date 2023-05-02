# class Operations::Sending::Account2Account < AppService
#   # include HistoryOperationsConstants
#   include Operations::Errors

#   option :account_from, Types::Account
#   option :account_to, Types::Account
#   option :payloads, Types::Commissions::Payload

#   option :card_form, Types::Card, optional: true  
#   option :card_to, Types::Card, optional: true  

#   def call
#     validate_accounts_currency!
#     ActiveRecord::Base.transaction do
#       decrease_account_from_balance!
#       increase_account_to_balance!
#       increase_bank_account_balance! if with_commission?
#       create_transaction!
#     end
#   end

#   private

#   def validate_accounts_currency!
#     return if account_from.currency == account_to.currency

#     raise Operations::Errors::WrongCurrency
#   end

#   def decrease_account_from_balance!
#     Operations::Accounts::Withdrawals.call(account: account_from, payload: payload_with_commission)
#   end

#   def increase_account_to_balance!
#     Operations::Accounts::Replenishment.call(account: account_to, payload: payload)
#   end

#   def increase_bank_account_balance!
#     options = { payload: commission_payload, currency: account_from.currency }

#     Operations::Bank::Receive.call(options)
#   end

#   def create_transaction!
#     Transaction.create!(
#       account_from: account_from,
#       account_to: account_to,
#       card_from: card_from,
#       card_to: card_to,
#       status: :unconfirmed,
#       operation_type: :transfer,
#       payload: payload,
#       commission: commission_payload,
#       processed_at: DateTime.now.in_time_zone
#     )
#   end

#   def payload
#     payloads.payload
#   end

#   def commission_payload
#     payloads.commission_payload
#   end

#   def payload_with_commission
#     payloads.payload_with_commission
#   end

#   def with_commission?
#     payload != payload_with_commission
#   end
# end
