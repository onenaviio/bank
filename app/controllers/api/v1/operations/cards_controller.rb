class Api::V1::Operations::CardsController < ApplicationController
  def replenishment
    Api::V1::Operations::Cards::Replenishment.call(card: card, payload: params[:payload])

    head :ok
  end

  def send_money
    card_to = Card.find_by!(number: params[:send_to_card_number])

    Api::V1::Operations::Cards::SendMoney.call(
      card_from: card,
      card_to: card_to,
      payload: params[:payload],
      commission: card.commission
    )

    head :ok
  end

  def withdrawals
    Api::V1::Operations::Cards::Withdrawals.call(account: card, payload: params[:payload])

    head :ok
  end

  private

  def cards
    @cards ||= current_user.cards
  end

  def card
    @card ||= cards.find(params[:id])
  end
end
