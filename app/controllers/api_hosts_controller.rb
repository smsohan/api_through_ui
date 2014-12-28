class ApiHostsController < ApplicationController
  def index
    @api_hosts = ApiExample.distinct(:host).sort
  end

  def versions
    @api_host = params[:api_host]
    @versions = ApiExample.where(host: @api_host).distinct(:version).sort.reverse
  end
end
