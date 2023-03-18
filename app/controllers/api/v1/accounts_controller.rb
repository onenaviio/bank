class Api::V1::AccountsController < ApplicationController
  def index
    render_collections(accounts)
  end

  def show
    render_json(current_user.accounts.find(params[:id]))
  end

  def create
    account = Api::V1::Accounts::Create.call(user: current_user, currency: params[:currency])

    render_json(account)
  end

  private

  def accounts
    @accounts ||= current_user.accounts
  end
end
