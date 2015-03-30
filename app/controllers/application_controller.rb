class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :add_home_breadcrumb

  private
  def add_home_breadcrumb
    add_breadcrumb "Home", :root_path
  end

end
