class ApiResourcesController < ApplicationController
  def index
    api_host = ApiHost.new(name: params[:api_host])
    api_version = ApiVersion.new(name: params[:api_version], api_host: api_host)
    @api_resources = api_version.api_resources
  end
end
