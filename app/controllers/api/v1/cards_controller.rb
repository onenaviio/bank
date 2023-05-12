class Api::V1::CardsController < ApplicationController
  def index
    render_collection(cards)
  end

  def show
    render_json(cards.find(params[:id]))
  end

  def create
    card = Api::V1::Cards::Create.call(account: account)

    render_json(card)
  end

  def update
    card.update!(name: params[:name])

    render_json(card)
  end

  private

  def cards
    @cards ||= current_user.cards
  end

  def card
    @card ||= cards.find(params[:id])
  end

  def account
    @account ||= current_user.accounts.find_by(id: params[:account_id])
  end
end
