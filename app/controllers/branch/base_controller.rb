class Branch::BaseController < ApplicationController
  before_action :branch

  private
  def branch
    @branch = Branch.active.friendly_find params[:branch_id]
  end
end
