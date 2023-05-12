class Api::V1::TransactionsController < ApplicationController
  def index
    render_collection(transactions)
  end

  private

  def transactions
    case params[:type].to_sym
    when :account
      Transactions::Index::ByAccount.call(account: account)
    else
      Transaction.none
    end
  end

  def account
    @account ||= current_user.accounts.find(params[:account_id])
  end
end
