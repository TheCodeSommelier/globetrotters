class SavedExperiencesController < ApplicationController
  def create
    @saved_experience = SavedExperience.new
    @saved_experience.journey = Journey.find(params[:saved_experience][:journey].to_i)
    @saved_experience.experience = Experience.find(params[:experience_id])
    if @saved_experience.save
      redirect_to journey_path(@saved_experience.journey)
    else
      render "experiences/index", status: :unprocessable_entity
    end
  end
end
