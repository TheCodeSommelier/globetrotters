class JourneysController < ApplicationController
  def new
    @journey = Journey.new
  end

end
