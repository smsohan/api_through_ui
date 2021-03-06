require 'test_helper'

class ApiVersionsControllerTest < ActionController::TestCase
  setup do
    ApiExample.create(host: 'cakeside.com', version: 'v1', url: '/api/v2/cakes.json')
    ApiExample.create(host: 'cakeside.com', version: 'v2')
    ApiExample.create(host: 'api.github.com')
  end

  test "shows the unique versions on the versions page" do
    get :index, api_host: 'cakeside.com'
    assert_response :success
    assert_equal %w{v2 v1}, assigns(:api_versions).map(&:name)
  end

end
