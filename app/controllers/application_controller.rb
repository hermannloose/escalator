class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do |c|
    Authorization.current_user = c.current_user
  end

  def permission_denied
    flash[:error] = "Sorry, you're not allowed to access that page."
    redirect_to new_user_session_path
  end
end
