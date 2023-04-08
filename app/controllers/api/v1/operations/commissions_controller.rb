class Api::V1::Operations::CommissionsController < ApplicationController
  def show
    render_json(commission: commission)
  end

  private

  def card
    @card ||= current_user.cards.find(params[:card_id])
  end

  def commission
    Operations::Commissions::Calculator.call(payload: params[:payload].to_i, commission: card.commission)
  end
end
