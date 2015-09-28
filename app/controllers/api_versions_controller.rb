class ApiVersionsController < ApplicationController
  def index
    @api_host = ApiHost.new(name: params[:api_host])
    @api_versions = @api_host.versions.sort_by(&:name).reverse

    add_breadcrumb @api_host.name + " Versions"
  end

end
