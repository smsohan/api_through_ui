require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'loads the user' do
    user = User.create!(username: 'blah', email: 'blah@example.com', password: 'password')

    get :show, id: user.username

    assert_response :success
    assert_equal(user, assigns(:user))
  end

  test 'loads the api hosts for the user' do
    user = User.create!(username: 'blah', email: 'blah@example.com', password: 'password')
    api_example = ApiExample.create!(user_id: user.id)

    get :show, id: user.username

    assert_response :success
    assert_equal([api_example], assigns(:api_examples))
  end
end
