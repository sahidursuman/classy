class BranchesController < ApplicationController
  def index
    training_center = Center.active.friendly_find params[:center_id]
    @q = training_center.active_branches.ransack params[:q]
    @branches = @q.result
    @support = Supports::TrainingCenter.new training_center
  end

  def show
    @branch = Branch.active.friendly_find params[:id]
  end
end
