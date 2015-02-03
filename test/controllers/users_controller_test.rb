require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'loads the user' do
    user = User.create!(username: 'blah', email: 'blah@example.com', password: 'password')

    get :show, id: user.username

    assert_response :success
    assert_equal(user, assigns(:user))
  end

  test 'loads the unique api hosts for the user' do
    user = User.create!(username: 'blah', email: 'blah@example.com', password: 'password')
    user.api_examples.create(host: 'cakeside.com', version: 'v1')
    user.api_examples.create(host: 'cakeside.com', version: 'v2')
    user.api_examples.create(host: 'api.github.com')

    get :show, id: user.username

    assert_response :success
    assert_equal %w{api.github.com cakeside.com}, assigns(:api_hosts).map(&:name)
  end
end
