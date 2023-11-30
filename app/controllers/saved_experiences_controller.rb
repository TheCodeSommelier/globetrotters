class SavedExperiencesController < ApplicationController
  before_action :set_saved_experience, only: [:destroy]

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

  def destroy
    @journey = @saved_experience.journey
    @saved_experience.destroy
    redirect_to journey_path(@journey), status: :see_other
  end

  private

  def set_saved_experience
    @saved_experience = SavedExperience.find(params[:id])
  end
end
