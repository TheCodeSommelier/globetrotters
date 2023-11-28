class JourneysController < ApplicationController
  def new
    @journey = Journey.new
  end

  def create
    @journey = Journey.new(journey_params)
    @journey.user = current_user
    if @journey.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def journey_params
    params.require(:journey).permit(:location, :start_date, :end_date, :category, :notes, :user)
  end
end
