class ApiHostsController < ApplicationController
  def index
    @api_hosts = ApiExample.distinct(:host).sort
  end

  def show
  end
end
