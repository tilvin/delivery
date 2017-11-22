class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  protect_from_forgery with: :exception

  rescue_from "AccessGranted::AccessDenied" do |exception|
    redirect_to :login, alert: "You don't have permission to access this page."
  end

end
