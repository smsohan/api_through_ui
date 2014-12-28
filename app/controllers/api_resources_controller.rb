class ApiResourcesController < ApplicationController
  def index
    @api_host = ApiHost.new(name: params[:api_host])
    @api_version = ApiVersion.new(name: params[:api_version], api_host: @api_host)
    @api_resources = @api_version.api_resources
  end

  def show
    @api_host = ApiHost.new(name: params[:api_host])
    @api_version = ApiVersion.new(name: params[:api_version], api_host: @api_host)
    @api_resource = ApiResource.new(name: params[:id], api_version: @api_version)

    @api_actions = @api_resource.api_actions
  end
end
