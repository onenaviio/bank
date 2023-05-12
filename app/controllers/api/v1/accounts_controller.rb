class Api::V1::AccountsController < ApplicationController
  def index
    render_collection(accounts)
  end

  def show
    render_json(current_user.accounts.find(params[:id]))
  end

  def create
    Api::V1::Accounts::Create.call(user: current_user, currency: params[:currency])

    render_json(accounts)
  end

  private

  def accounts
    @accounts ||= current_user.accounts
  end
end
