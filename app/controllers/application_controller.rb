class ApplicationController < ActionController::API
  include RenderMethods

  def current_user
    @current_user ||= User.last
  end
end
