require 'test_helper'

class ApiHostsControllerTest < ActionController::TestCase
  setup do
    ApiExample.create(host: 'cakeside.com')
    ApiExample.create(host: 'cakeside.com')
    ApiExample.create(host: 'api.github.com')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal assigns(:api_hosts), ['api.github.com', 'cakeside.com']
  end

end
