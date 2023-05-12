class Transactions::Index::ByAccount < AppService
  option :account, Types::Account

  def call
    scope = add_select(Transaction.all)
    scope = add_joins(scope)
    scope = add_filtering_by_account(scope)
    add_ordering(scope)
  end

  private

  def add_select(scope)
    scope.select(<<~SQL)
      users_from.id AS sender_id,
      users_from.last_name AS sender_last_name,
      users_from.first_name AS sender_first_name,
      users_from.patronymic AS sender_patronymic,
      users_to.id AS recepient_id,
      users_to.last_name AS recepient_last_name,
      users_to.first_name AS recepient_first_name,
      users_to.patronymic AS recepient_patronymic,
      transactions.operation_type,
      transactions.payload,
      transactions.commission_payload,
      transactions.comment,
      transactions.processed_at,
      transactions.failed_at,
      transactions.status
    SQL
  end

  def add_joins(scope)
    scope.joins(<<~SQL)
      LEFT JOIN accounts AS accounts_from
        ON accounts_from.id = transactions.account_from_id
      LEFT JOIN users AS users_from
        ON users_from.id = accounts_from.user_id
      LEFT JOIN accounts AS accounts_to
        ON accounts_to.id = transactions.account_to_id
      LEFT JOIN users AS users_to
        ON users_to.id = accounts_to.user_id
    SQL
  end

  def add_filtering_by_account(scope)
    scope.where(account_from: account.id).or(scope.where(account_to: account.id))
  end

  def add_ordering(scope)
    scope.order(started_at: :desc)
  end

  def username_query(table_name)
    "#{table_name}.last_name AND #{table_name}.first_name AND #{table_name}.patronymic"
  end
end
