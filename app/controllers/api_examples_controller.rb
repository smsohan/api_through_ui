class ApiExamplesController < ApplicationController

  def index
    @api_examples = ApiExample.all
  end

end
