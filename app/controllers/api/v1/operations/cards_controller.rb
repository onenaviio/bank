class Api::V1::Operations::CardsController < ApplicationController
  include OperationsConstants

  def replenishment
    Transactions::Creator::ByCard.call(
      card_from: card,
      card_to: card,
      operation_type: :replenishment,
      payloads: Types::Commissions::Payload[
        payload: params[:payload].to_f,
        commission_payload: 0.0
      ],
      params: {
        comment: REPLENISHMENT_TITLE
      }
    )

    head :ok
  end

  def send_money
    Transactions::Creator::ByCard.call(
      card_from: card,
      card_to: Card.find_by!(number: params[:send_to_card_number]),
      operation_type: :transfer,
      payloads: Operations::Commissions::Calculator.call(payload: params[:payload], commission: card.commission),
      params: transfer_params[:transfer]
    )

    head :ok
  end

  def withdrawals
    Transactions::Creator::ByCard.call(
      card_from: card,
      card_to: card,
      operation_type: :withdrawals,
      payloads: Types::Commissions::Payload[
        payload: params[:payload].to_f,
        commission_payload: 0.0 # TODO: implement commission for withdrawals
      ],
      params: {
        comment: WITHDRAWALS_TITLE
      }
    )

    head :ok
  end

  private

  def payloads
    
  end

  def transfer_params
    params.permit(transfer: %i[comment])
  end

  def cards
    @cards ||= current_user.cards
  end

  def card
    @card ||= cards.find(params[:id])
  end
end
