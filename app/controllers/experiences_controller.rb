class ExperiencesController < ApplicationController

  def index
    if params[:query].present?
      @experience = PgSearch.multisearch(params[:query])
    else
      @experience = Experience.all
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
    params.require(:experience).permit(:title, :content, :address, :category, :journey)
  end
end
