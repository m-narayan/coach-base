class CoursesController < ApplicationController
  include SocialStream::Controllers::Subjects
  include SocialStream::Controllers::Authorship

  before_filter :authenticate_user!, :except => [ :index, :show ]

  load_and_authorize_resource except: :index

  respond_to :html, :js

  #def index
  #  #@courses =current_user.courses.paginate(:per_page => 5, :page => params[:page])
  #  @courses =current_user.courses
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @courses }
  #
  #  end
  #end


  #
  #def create
  #  create! do |success, failure|
  #    success.html {
  #      self.current_subject = resource
  #
  #      flash[:notice] += t('representation.notice',
  #                          :subject => resource.name)
  #
  #      redirect_to :home
  #    }
  #  end
  #end

  def destroy
    destroy! do |success, failure|
      success.html {
        self.current_subject = current_user
        redirect_to :home
      }
    end
  end
end
