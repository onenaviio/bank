module Types
  include Dry.Types()

  Card        = Types.Instance(::Card)
  Account     = Types.Instance(::Account)
  User        = Types.Instance(::User)
  Transaction = Types.Instance(::Transaction)

  Currency = Types::String.enum(*::Account.currencies.keys)

  StringOrSymbol = Types::String | Types::Symbol
end
