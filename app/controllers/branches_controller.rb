class BranchesController < ApplicationController
  def index
    training_center = TrainingCenter.active.friendly_find params[:training_center_id]
    @q = training_center.active_branches.ransack params[:q]
    @branches = @q.result
    @support = Supports::TrainingCenter.new training_center
  end
end
