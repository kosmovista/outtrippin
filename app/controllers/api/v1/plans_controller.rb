class Api::V1::PlansController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def index
    @plans = Plan.where(published: true)
  end
end
