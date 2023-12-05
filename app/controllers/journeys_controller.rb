require "json"
require "open-uri"
require "net/http"

class JourneysController < ApplicationController
  before_action :set_journey, only: %i[show update delete_packing_item]

  def show
    # This is the api call to display the current weather
    weather = openweather_api_call
    country_code = weather['sys']['country']
    currency_and_language = big_data_api_call(country_code)

    # This gets all the data we are displaying in the show
    data_setter(weather, currency_and_language)

    # This will display the markers on the map
    experiences = @sight_seeing_list.map { |saved_experience| saved_experience.experience }
    mapbox_building(experiences)
  end

  def new
    @journey = Journey.new
  end

  def create
    @journey = Journey.new(journey_params)
    @journey.user = current_user
    if @journey.save!
      redirect_to journey_path(@journey)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @packing_list = @journey.packing_list << params[:journey][:packing_item]
    @packing_item = params[:journey][:packing_item]
    @journey.update(packing_list: @packing_list)

    respond_to do |format|
      format.html { redirect_to journey_path(@journey) }
      format.json # Follows the classic Rails flow and look for a create.json view
    end
  end

  def delete_packing_item
    @journey.packing_list.delete_at(params[:packingItem].to_i)
    @journey.save!
  end

  private

  # From this call we get weather temperature, an icon of current weather in destiation, time zone and country code
  def openweather_api_call
    serialized_weather = URI("https://api.openweathermap.org/data/2.5/weather?q=#{@journey.location}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=metric")
    JSON.parse(Net::HTTP.get(serialized_weather))
  end

  # From this api call we get language and currency
  def big_data_api_call(country_code)
    uri_big_data = URI("https://api-bdc.net/data/country-info?code=#{country_code}&localityLanguage=en&key=#{ENV['BIG_DATA_API_KEY']}")
    JSON.parse(Net::HTTP.get(uri_big_data))
  end

  def data_setter(weather, currency_and_language)
    # Displays language
    @journey.language = currency_and_language['isoAdminLanguages'].first['isoName']

    # Displays currency
    @journey.currency = currency_and_language['currency']['code']

    # Sets the correct experiences
    @sight_seeing_list = @journey.saved_experiences

    # Gets the temparature
    @temperature_for_journey = weather["main"]["temp"]

    # Gets the icon for weather
    icon_id = weather['weather'].last['icon']
    @current_weather_icon_path = "https://openweathermap.org/img/w/#{icon_id}.png"

    # Gets time zone
    utc_offset_seconds = weather['timezone']
    @current_time_in_location = get_time_zone_identifier_by_utc_offset(utc_offset_seconds)
  end

  # Makes the markers for the map
  def mapbox_building(experiences_to_display)
    @markers = experiences_to_display.map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        experience_popup_html: render_to_string(partial: "experience_popup", locals: { experience: experience }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  # Check if everything pice of data is present for journey once CHATGPT up delete!
  # def fill_in_missing_data
  #   if @journey.packing_list.present?
  #     return
  #   elsif @journey.notes.nil?
  #     @journey.notes = "My trip to #{@journey.location}"
  #   else
  #     @journey.packing_list = "mug, passport, money, underwear, favourite plushie"
  #   end
  # end

  # Gets the time zone identifier by the UTC offset
  def get_time_zone_identifier_by_utc_offset(utc_offset_seconds)
    time_zone = ActiveSupport::TimeZone.all.find { |tz| tz.utc_offset == utc_offset_seconds }
    time_zone.formatted_offset
  end

  def set_journey
    @journey = Journey.find(params[:id])
  end

  def journey_params
    params.require(:journey).permit(:location, :start_date, :end_date, :category, :notes, :user, :packing_item)
  end
end
