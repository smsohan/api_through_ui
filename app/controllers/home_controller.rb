class HomeController < ApplicationController

  skip_before_action :add_home_breadcrumb

  def index
  end
end
