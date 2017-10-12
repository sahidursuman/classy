class TrainingCentersController < ApplicationController
  def show
    @training_center = TrainingCenter.active.friendly_find params[:id]
  end
end
