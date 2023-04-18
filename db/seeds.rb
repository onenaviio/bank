def create_account_and_card(user)
  account = user.accounts.find_by(currency: :rub) || Api::V1::Accounts::Create.call(user: user, currency: :rub)
  return if account.cards.exists?

  Api::V1::Cards::Create.call(account: account)
end

# === SERVICE RATES ===
ServiceRate.find_or_create_by!(
  title: "Базовый",
  service_per_month: 20,
  c2c_commission_type: ApplicationConstants::DEFAULT_COMMISSION_TYPE,
  c2c_commission_value: ApplicationConstants::CARD2CARD_COMMISSION_PERCENT
)

ServiceRate.find_or_create_by!(
  title: "Начальный",
  service_per_month: 450,
  c2c_commission_type: :value,
  c2c_commission_value: 150
)

ServiceRate.find_or_create_by!(
  title: "Продвинутый",
  service_per_month: 1500,
  c2c_commission_type: ApplicationConstants::DEFAULT_COMMISSION_TYPE,
  c2c_commission_value: 0.1
)
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
  next if bank_user.accounts.where(currency: currency).exists?

  Api::V1::Accounts::Create.call(user: bank_user, currency: currency)
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
