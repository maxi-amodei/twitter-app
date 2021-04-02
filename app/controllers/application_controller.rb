class ApplicationController < ActionController::Base
  include Clearance::Controller
  
  def current_user
    # This is to handle unregistered users entering the users page
    super || Guest.new
  end
end
