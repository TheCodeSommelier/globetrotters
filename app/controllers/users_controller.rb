class UsersController < ApplicationController
  def profile_page
    @user = current_user
    @journeys = @user.journeys
  end

  def index
    if params[:query].present?
      @users = User.search_by_username(params[:query])
    else
      @users = User.all
    end
  end

end
