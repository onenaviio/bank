class Api::V1::Cards::Create < AppService
  def initialize(account:)
    @account = account
  end

  def call
    account.cards.create!(
      name: name,
      number: number,
      expires_date: expires_date,
      cvv: cvv
    )
  end

  private

  attr_reader :account

  def name
    "Card ##{account.cards.count + 1}"
  end

  def number
    (0..3).map { rand(1000..9999) }.join
  end

  def expires_date
    Date.current + 5.years
  end

  def cvv
    rand(100..999)
  end
end
