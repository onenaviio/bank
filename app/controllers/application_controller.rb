class ApplicationController < ActionController::API
  include RenderMethods
  include ApplicationConstants

  def current_user
    @current_user ||= User.find(request.headers["HTTP_USER_ID"])
  end

  # card to card
  # account to account
  # by phone
end
