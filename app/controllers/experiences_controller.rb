class ExperiencesController < ApplicationController

  def index
    @saved_experience = SavedExperience.new
    if params[:query].present?
      @journeys = Journey.search_by_location(params[:query])
      @experiences = []
      @journeys.each do |journey|
        journey.experiences.each do |experience|
          @experiences << experience
        end
      end
    else
      @experiences = Experience.all
    end
  end

  def new
    @journey = Journey.find(params[:journey_id])
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)
    @journey = Journey.find(params[:journey_id])
    @experience.journey = @journey
    if @experience.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def experience_params
    params.require(:experience).permit(:title, :content, :address, :category, :journey, photos: [])
  end
end
