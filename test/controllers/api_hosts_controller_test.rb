require 'test_helper'

class ApiHostsControllerTest < ActionController::TestCase
  setup do
    ApiExample.create(host: 'cakeside.com', version: 'v1')
    ApiExample.create(host: 'cakeside.com', version: 'v2')
    ApiExample.create(host: 'api.github.com')
  end

  test "gets the unique hostnames" do
    get :index
    assert_response :success
    assert_equal %w{api.github.com cakeside.com}, assigns(:api_hosts).map(&:name)
  end

  test "shows the unique versions on the versions page" do
    get :versions, api_host: 'cakeside.com'
    assert_response :success
    assert_equal %w{v2 v1}, assigns(:versions).map(&:name)
  end

end
