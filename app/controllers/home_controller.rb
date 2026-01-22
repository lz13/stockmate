class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    # This will require authentication due to ApplicationController settings
  end
end
