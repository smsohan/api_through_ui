class ApiHostsController < ApplicationController
  def index
    @api_hosts = ApiHost.all.sort_by(&:name)
  end

  def versions
    @api_host = ApiHost.new(name: params[:api_host])
    @versions = @api_host.versions.sort_by(&:name).reverse
  end
end
