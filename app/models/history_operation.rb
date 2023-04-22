class HistoryOperation < ApplicationRecord
  enum operation_type: %i[transactions payments]

  belongs_to :account
  belongs_to :card, optional: true

  validates :title, :payload, :processed_at, :operation_type, presence: true

  def typed_extra_data
    Types::HistoryOperations::TypedExtraData[extra_data.deep_symbolize_keys]
  end
end
