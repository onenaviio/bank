class Api::V1::UsersController < ApplicationController
  def index
    render_json(current_user)    
  end

  def create
    user = Api::V1::Users::Create.call(user_params)

    render_json(user)
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :patronymic, :birthday, :phone, :email, :password)
  end
end
