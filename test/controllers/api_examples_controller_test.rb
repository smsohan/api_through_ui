require 'test_helper'

class ApiExamplesControllerTest < ActionController::TestCase
  setup do
    @api_example = ApiExample.create(host: 'cakeside.com', url:"/cakes", http_method: 'GET')
  end

  test 'it destroys the example' do
    delete :destroy, id: @api_example.id
    assert_raises Mongoid::Errors::DocumentNotFound do
      ApiExample.find(id: @api_example.id)
    end
  end

end