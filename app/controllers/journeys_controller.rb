require "json"
require "open-uri"

class JourneysController < ApplicationController
  before_action :set_journey, only: %i[show]

  def show
    url_weather = "https://api.openweathermap.org/data/2.5/weather?q=#{@journey.location}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=metric"
    serialized_weather = URI.open(url_weather).read
    weather = JSON.parse(serialized_weather)
    @temperature_for_journey = weather["main"]["temp"]
    icon_id = weather['weather'].last['icon']
    @current_weather_icon_path = "https://openweathermap.org/img/w/#{icon_id}.png"
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
  end
end
