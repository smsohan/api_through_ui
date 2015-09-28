class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :add_home_breadcrumb

  helper_method :show_comments?
  helper_method :write_enabled?

  protected
  def show_comments?
    write_enabled?
  end

  private
  def add_home_breadcrumb
    add_breadcrumb "Home", :root_path
  end

  def write_enabled?
    ApiThroughUi::Application.config.write_enabled
  end

  def require_write_enabled
    unless write_enabled?
      render nothing: true, status: :not_authorized
    end
  end


end
