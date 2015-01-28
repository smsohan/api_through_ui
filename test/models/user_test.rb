require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "creates a auth token" do
    user = User.create!(username: 'blah', email: 'blah@example.com', password: 'password', password_confirmation: 'password')
    assert user.api_token
  end

  test "validates unique username" do
    user = User.create!(username: 'username', email: 'blah@example.com', password: 'password', password_confirmation: 'password')
    assert user.valid?

    user = User.new(username: 'username', email: 'blahblah@example.com', password: 'password', password_confirmation: 'password')
    assert user.valid? == false
    assert user.errors[:username].empty? == false
  end

  test 'validates presence of usernaem' do
    user = User.new(username: nil)
    assert user.valid? == false
    assert user.errors[:username].empty? == false
  end
end
