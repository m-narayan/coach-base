class FrontpageController < ApplicationController
  include SocialStream::Devise::Controllers::UserSignIn

  before_filter :redirect_user_to_home, :only => :index

  def index
    @events = Event.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def course_details
    @event=Event.find(params[:id])
  end

  def my_courses
    @events = current_user.events
  end

  private

  def redirect_user_to_home
    redirect_to(home_path) if user_signed_in?
  end



end

