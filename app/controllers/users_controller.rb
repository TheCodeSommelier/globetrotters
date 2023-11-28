class UsersController < ApplicationController
  def profile_page
    @user = current_user
  end
end
