class UsersController < ApplicationController
  def profile_page
    @user = current_user
    @journeys = @user.journeys
    # @experiences = @user.experiences
  end
end

# Could get all instances of experiences as an array and iterate and show on page
