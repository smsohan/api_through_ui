require 'test_helper'

class ApiActionDescriptionsControllerTest < ActionController::TestCase
  test "create" do
    xhr :post, :create, api_action_description: {api_host: 'api.x.com',
      api_version: 'v1', api_resource: 'R',
      api_action: 'GET /some',
      description: 'Does something' }
    assert_response :success
    assert_match /Does something/, response.body
  end

  test "validates on create" do
    assert_raises Mongoid::Errors::Validations do
      post :create, api_action_description: {api_host: 'api.x.com',
      api_version: 'v1', api_resource: 'R',
      description: 'Does something' }
    end
  end

  test 'updates the description' do
    api_action_description = ApiActionDescription.create!(
      api_host: 'api.x.com',
      api_version: 'v1', api_resource: 'R',
      api_action: 'GET /some',
      description: 'Does something'
      )

    xhr :put, :update, id: api_action_description.id, api_action_description: {
      description: 'Does something new'
    }

    assert_response :success
    assert_match /Does something new/, response.body

  end

end
