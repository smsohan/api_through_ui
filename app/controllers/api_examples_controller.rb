class ApiExamplesController < ApplicationController

  def index
    @api_host = ApiHost.new(name: params[:api_host])
    @api_version = ApiVersion.new(name: params[:api_version], api_host: @api_host)
    @api_resource = ApiResource.new(name: params[:api_resource], api_version: @api_version)
    @api_examples = @api_resource.api_examples
  end

end
