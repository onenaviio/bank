class Api::V1::Operations::CardsController < ApplicationController
  include OperationsConstants

  def replenishment
    transaction = Transactions::Creator::ByCard.call(
      card_from: card,
      card_to: card,
      operation_type: :replenishment,
      payloads: Types::Commissions::Payload[
        payload: params[:payload].to_f,
        commission_payload: 0.0
      ],
      params: {
        comment: REPLENISHMENT_TITLE
      },
      perform: false
    )

    Transactions::Handler::Replenishment.call(transaction)

    head :ok
  end

  def send_money
    Transactions::Creator::ByCard.call(
      card_from: card,
      card_to: Card.find_by!(number: params[:send_to_card_number]),
      operation_type: :transfer,
      payloads: Types::Commissions::Payload[
        payload: params[:payload].to_f,
        commission_payload: card.commission_for_send(params[:payload])
      ],
      params: transfer_params[:transfer]
    )

    head :ok
  end

  def withdrawals
    transaction = Transactions::Creator::ByCard.call(
      card_from: card,
      card_to: card,
      operation_type: :withdrawals,
      payloads: Types::Commissions::Payload[
        payload: params[:payload].to_f,
        commission_payload: card.commission_for_withdrawals(params[:payload])
      ],
      params: {
        comment: WITHDRAWALS_TITLE
      },
      perform: false
    )

    Transactions::Handler::Withdrawals.call(transaction)

    head :ok
  end

  private

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
