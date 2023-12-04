class UsersController < ApplicationController
  def profile_page
    set_user
    @journeys = @user.journeys
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
