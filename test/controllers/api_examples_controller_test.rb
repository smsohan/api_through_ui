require 'test_helper'

class ApiExamplesControllerTest < ActionController::TestCase
  setup do
    @api_example = ApiExample.create(host: 'cakeside.com', url:"/cakes", http_method: 'GET')
  end

  test 'it destroys the example' do
    delete :destroy, id: @api_example.id
    ApiExample.find(@api_example.id).must_equal nil
  end

end