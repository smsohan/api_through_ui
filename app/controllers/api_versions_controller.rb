class ApiVersionsController < ApplicationController
  def index
    @api_host = ApiHost.new(name: params[:api_host])
    @api_versions = @api_host.versions.sort_by(&:name).reverse
  end

  def show
  end
end
