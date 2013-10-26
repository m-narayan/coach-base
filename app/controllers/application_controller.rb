class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def after_sign_in_path_for(resource_or_scope)
    if redirect_back_req?
      redirect_back
    end
  end
end
