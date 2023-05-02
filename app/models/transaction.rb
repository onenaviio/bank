class Transaction < ApplicationRecord
  OPERATION_TYPES = %w[transfer external_payment commission monthly_payment withdrawals replenishment].freeze
  STATUSES = %w[unconfirmed confirmed cancelled failed].freeze

  enum operation_type: OPERATION_TYPES.zip(OPERATION_TYPES).to_h, _prefix: true
  enum status: STATUSES.zip(STATUSES).to_h, _prefix: true

  belongs_to :account_from, class_name: "Account", foreign_key: :account_from_id
  belongs_to :account_to, class_name: "Account", foreign_key: :account_to_id, optional: true
  belongs_to :card_from, class_name: "Card", foreign_key: :card_from_id, optional: true
  belongs_to :card_to, class_name: "Card", foreign_key: :card_to_id, optional: true

  validates :external_account_to_id, presence: true, if: -> { external_account_to_type.present? }
  validates :payload, :started_at, presence: true

  def fail!
    update!(status: :failed, failed_at: DateTime.now.in_time_zone)
  end

  def confirm!
    update!(status: :confirmed, processed_at: DateTime.now.in_time_zone)
  end
end
