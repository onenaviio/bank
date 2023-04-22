class Api::V1::Users::Create < AppService
  param :user_params, default: -> { {} }

  def call
    user = User.create!(user_params)
    send_email!(user)
    user
  end

  private

  def send_email!(user); end
end
