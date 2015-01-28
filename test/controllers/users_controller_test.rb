require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'loads the user' do
    user = User.create!(username: 'blah', email: 'blah@example.com', password: 'password')

    get :show, id: user.username

    assert_response :success
    assert_equal(user, assigns(:user))
  end
end
