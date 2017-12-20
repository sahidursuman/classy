class Admin::CitiesController < Admin::BaseController
  before_action :authenticate_root!

  def index
    @cities = City.priority_desc.includes :districts
  end
end
