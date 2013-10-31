class FrontpageController < ApplicationController
  include SocialStream::Devise::Controllers::UserSignIn
  include SessionsHelper
  before_filter :redirect_user_to_home, :only => :index
  before_filter :signed_in_user, :only => :payment_confirm

  def index
    @courses = Course.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def course_details
    @course=Course.find(params[:id])
    #event.payments.find_by_user_id_and_event_id(2,1)
    @events=@course.events
    @users = []
    @enrolled_events=[]
    @other_events=[]
    @course.events.each do |event|
      event.payments.each do |payment|
        @users << payment.user
        if payment.user_id == current_user.id
          @enrolled_events << payment.event
        end
      end
    end
    @users=@users.uniq
    @other_events=@events - @enrolled_events.uniq
  end

  def payment_confirm
    @event=Event.find(params[:id])
    @grouped_payments = [[Payment.digital.build]]
  end


  def my_courses
    @events = current_user.events
  end

  def enrolled_courses
    @events = Event.where(id: Payment.where(:user_id =>current_user.id,:completed=>true).map(&:event_id))
    if @events.event.start_at > Time.now

    end

  end

  def completed_courses
    @events = Event.where(id: Payment.where(:user_id =>current_user.id,:completed=>true).map(&:event_id))
    if @events.event.start_at > Time.now

    end
  end

  private

  def redirect_user_to_home
    redirect_to(home_path) if user_signed_in?
  end


end

