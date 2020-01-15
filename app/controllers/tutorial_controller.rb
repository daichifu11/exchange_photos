class TutorialController < ApplicationController
  skip_before_action :authenticate_user!
  def top
    if current_user
      redirect_to current_user
    end
  end
end
