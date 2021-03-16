class TrainingsController < ApplicationController
  def index
    part = Part.find(params[:part_id])
    render json: part.trainings.select(:id, :name)
  end
end
