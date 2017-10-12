class BranchesController < ApplicationController
  def index
    training_center = TrainingCenter.active.friendly_find params[:training_center_id]
    @branches = training_center.branches.active
  end
end
