class HomeController < ApplicationController

  skip_before_action :add_home_breadcrumb

  def index
  end

  protected
  def show_comments?
    false
  end

end
