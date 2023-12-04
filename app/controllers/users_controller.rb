class UsersController < ApplicationController
  def profile_page
    set_user
    @journeys = @user.journeys
  end

  def index
    if params[:query].present?
      @users = User.search_by_username(params[:query])
    else
      @users = User.all
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
