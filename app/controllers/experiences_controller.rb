class ExperiencesController < ApplicationController

  def index
    if params[:query].present?
      @experience = PgSearch.multisearch(params[:query])
    else
      @experience = Experience.all
    end
  end
end
