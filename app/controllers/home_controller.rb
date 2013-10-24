class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = Event.all
    respond_to do |format|
      format.html
      format.json { render json: home_json }
    end
  end

  private

  def home_json
    {
      name: current_subject.name
    }.to_json
  end
end
