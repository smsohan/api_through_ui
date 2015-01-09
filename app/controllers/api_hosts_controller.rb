class ApiHostsController < ApplicationController
  protect_from_forgery :except => [:echo]
  http_basic_authenticate_with name: "user", password: "pass", only: :echo

  def index
    @api_hosts = ApiHost.all.sort_by(&:name)
  end

  def echo
    render json: params
  end
end
