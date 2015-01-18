require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "creates a auth token" do
    user = User.create!(email: 'blah@example.com', password: 'password', password_confirmation: 'password')
    assert user.api_token
  end
end
