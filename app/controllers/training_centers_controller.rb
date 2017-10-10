class TrainingCentersController < ApplicationController
  def show
    @training_center = TrainingCenter.friendly_find params[:id]
  end
end
