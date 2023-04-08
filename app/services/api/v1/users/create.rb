class Api::V1::Users::Create < AppService
  def initialize(user_params = {})
    @user_params = user_params
  end

  def call
    user = User.create!(user_params)
    send_email!(user)
    user
  end

  private

  attr_reader :user_params

  def send_email!(user); end
end
