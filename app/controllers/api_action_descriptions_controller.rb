class ApiActionDescriptionsController < ApplicationController
  def create
    api_action_description = ApiActionDescription.new(descriptions_params)
    api_action_description.save!
    render json: api_action_description
  end

  def update
    api_action_description = ApiActionDescription.find(params[:id])
    api_action_description.description = descriptions_params[:description]
    api_action_description.save!
    render json: api_action_description
  end

  private
  def descriptions_params
    params.require(:api_action_description).permit( :api_host, :api_version, :api_resource, :api_action, :description)
  end
end
