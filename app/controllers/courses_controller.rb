class CoursesController < ApplicationController
  before_filter :hack_auth , :only => [ :create,:update]
  before_filter :check_coach , :only => [ :new,:create,:update,:destroy]
  load_and_authorize_resource except: [ :course_profile]
  include SocialStream::Controllers::Objects

  # GET /courses
  # GET /courses.json
  def index
    @courses =current_user.courses.paginate(:per_page => 5, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }

    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to courses_path, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def course_profile
    @course=Course.find(params[:course_id])
    @events = []
    @events = Event.where("start_date >= ?", Date.today).where("course_id =?",params[:course_id])
    @users = []
    @enrolled_events=[]
    @other_events=[]
    @events.each do |event|
      event.payments.each do |payment|
        @users << payment.user
        if !current_user.nil?
          if  payment.user_id == current_user.id
            @enrolled_events << payment.event
          end
        end
      end
    end
    @users=@users.uniq
    @other_events=@events - @enrolled_events.uniq
  end


  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.

  def hack_auth
    params["course"] ||= {}
    params["course"]["relation_ids"] = [Relation::Public.instance.id]
    params["course"]["owner_id"] = current_subject.actor_id
    params["course"]["author_id"] = current_subject.actor_id
    params["course"]["user_author_id"] = current_subject.actor_id
    params["course"]["user_id"] = current_user.id
    params[:course].permit!
  end

  def check_coach
    redirect_to(root_path) unless current_user.user_type == "coach"
  end


end
