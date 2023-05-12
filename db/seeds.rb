def create_account_and_card(user)
  account = user.accounts.find_by(currency: :rub) || Api::V1::Accounts::Create.call(user: user, currency: "rub")
  account.update(balance: 0)
  return if account.cards.exists?

  Api::V1::Cards::Create.call(account: account)
end

# === SERVICE RATES ===
bank_service_rate = ServiceRate.find_or_create_by!(
  title: "Банк",
  service_per_month: 0,
  c2c_commission_type: "value",
  c2c_commission_value: 0,
  withdrawals_commission_type: "value",
  withdrawals_commission_value: 0
)
bank_service_rate.build_month_limit(
  withdrawals_to_commission: -1,
  c2c_external_to_commission: -1,
  c2c_internal_to_commission: -1,
  sbp_to_commission: -1
).save

base = ServiceRate.find_or_create_by!(
  title: "Базовый",
  service_per_month: 20,
  c2c_commission_type: ApplicationConstants::DEFAULT_COMMISSION_TYPE,
  c2c_commission_value: ApplicationConstants::CARD2CARD_COMMISSION_PERCENT,
  withdrawals_commission_type: "value",
  withdrawals_commission_value: 200
)
base.build_month_limit(
  withdrawals_to_commission: 100_000,
  c2c_external_to_commission: 150_000,
  c2c_internal_to_commission: 1_000_000,
  sbp_to_commission: 500_000
).save

start = ServiceRate.find_or_create_by!(
  title: "Начальный",
  service_per_month: 450,
  c2c_commission_type: :value,
  c2c_commission_value: 150,
  withdrawals_commission_type: "percent",
  withdrawals_commission_value: 2.5
)
start.build_month_limit(
  withdrawals_to_commission: 200_000,
  c2c_external_to_commission: 250_000,
  c2c_internal_to_commission: 2_000_000,
  sbp_to_commission: 1_000_000
).save

advanced = ServiceRate.find_or_create_by!(
  title: "Продвинутый",
  service_per_month: 1500,
  c2c_commission_type: ApplicationConstants::DEFAULT_COMMISSION_TYPE,
  c2c_commission_value: 0.1,
  withdrawals_commission_type: "percent",
  withdrawals_commission_value: 1
)
advanced.build_month_limit(
  withdrawals_to_commission: 500_000,
  c2c_external_to_commission: 1_000_000,
  c2c_internal_to_commission: 5_000_000,
  sbp_to_commission: 2_000_000
).save
# =====================

# === BANK ===
bank_user = User.find_or_create_by!(
  first_name: "K.O. Bank",
  last_name: "*",
  patronymic: "*",
  phone: "*",
  email: "bank@bank.ru",
  password: "123123",
  birthday: "2023-03-17"
)

Account.currencies.each_key do |currency|
  account = bank_user.accounts.find_by(currency: currency)

  next account.update(service_rate: bank_service_rate) if account.present?

  account = Api::V1::Accounts::Create.call(user: bank_user, currency: currency)
  account.update(service_rate: bank_service_rate)
end
# ============

# === USERS ===
user1 = User.find_or_create_by!(
  first_name: "Олег",
  last_name: "Кроль",
  patronymic: "Олегович",
  phone: "89236824420",
  email: "krol-oleg@bk.ru",
  password: "123123",
  birthday: "1996-11-09"
)

create_account_and_card(user1)

user2 = User.find_or_create_by!(
  first_name: "Валерия",
  last_name: "Кроль",
  patronymic: "Витальевна",
  phone: "89087935901",
  email: "lera-oleg@bk.ru",
  password: "123123",
  birthday: "1997-01-14"
)

create_account_and_card(user2)
# ============
