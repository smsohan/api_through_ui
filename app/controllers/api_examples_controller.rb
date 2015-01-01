class ApiExamplesController < ApplicationController

  def curl
    @api_example = ApiExample.find(params[:id])
  end

end
