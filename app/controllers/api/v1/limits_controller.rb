class Api::V1::LimitsController < ApplicationController
  def index
    render_json(ReachedLimits::Index.call(current_user))
  end
end
