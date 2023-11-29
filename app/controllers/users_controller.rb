class UsersController < ApplicationController
  def profile_page
    @user = current_user
    @journeys = @user.journeys
  end
end
