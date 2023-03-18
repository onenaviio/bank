class Users::Create < AppService
  def initialize(kwargs = {})
    @first_name = kwargs[:first_name]
    @last_name  = kwargs[:last_name]
    @patronymic = kwargs[:patronymic]
    @phone      = kwargs[:phone]
    @email      = kwargs[:email]
    @password   = kwargs[:password]
  end

  def call
    user = User.create!(
      first_name: first_name,
      last_name: last_name,
      patronymic: patronymic,
      phone: phone,
      email: email,
      password: password
    )

    user
  end

  private

  attr_reader :first_name, :last_name, :patronymic, :phone, :email, :password
end
