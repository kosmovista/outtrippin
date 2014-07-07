class Admin::PlacesController < ApplicationController
  before_action :authorize_user
  before_action :authorize_admin

  def index
    @places = Place.all
  end
end