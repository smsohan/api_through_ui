class ApiHostsController < ApplicationController
  def index
    @api_hosts = ApiHost.all.sort_by(&:name)
  end
end
