require "json"
require "open-uri"

class JourneysController < ApplicationController
  before_action :set_journey, only: %i[show]

  def show
    # This is the api call to display the current weather
    url_weather = "https://api.openweathermap.org/data/2.5/weather?q=#{@journey.location}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=metric"
    serialized_weather = URI.open(url_weather).read
    weather = JSON.parse(serialized_weather)

    # For displaying temparature and weather icon
    @temperature_for_journey = weather["main"]["temp"]
    icon_id = weather['weather'].last['icon']
    @current_weather_icon_path = "https://openweathermap.org/img/w/#{icon_id}.png"

    # For displaying timezone
    utc_offset_seconds = weather['timezone']
    @current_time_in_location = get_time_zone_identifier_by_utc_offset(utc_offset_seconds)

    # To display the experiences ordered by likes
    @sight_seeing_list = @journey.saved_experiences

    # Packing list landuage and currency for journey DELETE ONCE CHATGPT
    fill_in_missing_data
  end

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

  # Check if everything pice of data is present for journey once CHATGPT up delete!
  def fill_in_missing_data
    if @journey.packing_list.present?
      return
    else
      @journey.packing_list = "mug, passport, money, underwear, favourite plushie"
      @journey.language = "Italian"
      @journey.currency = "EUR"
    end
  end

  # Gets the time zone identifier by the UTC offset
  def get_time_zone_identifier_by_utc_offset(utc_offset_seconds)
    time_zone = ActiveSupport::TimeZone.all.find { |tz| tz.utc_offset == utc_offset_seconds }
    time_zone.formatted_offset
  end

  def set_journey
    @journey = Journey.find(params[:id])
  end

  def journey_params
    params.require(:journey).permit(:location, :start_date, :end_date, :category, :notes, :user)
  end
end
