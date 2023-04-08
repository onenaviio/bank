module ApplicationConstants
  CARD2CARD_COMMISSION_PERCENT = ENV.fetch("CARD2CARD_COMMISSION_PERCENT", 0.5).freeze
  CARD2CARD_COMMISSION_VALUE = ENV.fetch("CARD2CARD_COMMISSION_VALUE", 100).freeze

  COMMISSION_TYPES = %w[percent value].freeze
  DEFAULT_COMMISSION_TYPE = :percent
end