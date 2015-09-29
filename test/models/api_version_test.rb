require 'test_helper'

class ApiVersionTest < ActiveSupport::TestCase
  test 'import and export works' do
    old_example = ApiExample.create!(host: 'test.some.host',  version: 'v0', resource: 'resource', action: 'GET /something')
    old_desc = ApiActionDescription.create!(api_host: 'test.some.host', api_version: 'v0', api_resource: 'resource', api_action: 'GET /something', description: 'custom')

    api_version = ApiVersion.new(api_host: ApiHost.new(name: 'test.some.host'), name: 'v0')

    exported = api_version.export

    prod_host = 'prod.some.host'
    ApiVersion.import(prod_host, exported)

    assert_equal ApiExample.where(host: prod_host).count, 1
    assert_equal ApiActionDescription.where(api_host: prod_host).count, 1

    new_example = ApiExample.where(host: prod_host).first
    assert_equal new_example.version, old_example.version
    assert_equal new_example.resource, old_example.resource
    assert_equal new_example.action, old_example.action

    new_desc = ApiActionDescription.where(api_host: prod_host).first
    assert_equal new_desc.description, old_desc.description
    assert_equal new_desc.api_version, old_desc.api_version
    assert_equal new_desc.api_resource, old_desc.api_resource
    assert_equal new_desc.api_action, old_desc.api_action

    File.unlink(exported)
  end

  test 'clear!' do
    old_example = ApiExample.create!(host: 'test.some.host',  version: 'v0', resource: 'resource', action: 'GET /something')
    old_desc = ApiActionDescription.create!(api_host: 'test.some.host', api_version: 'v0', api_resource: 'resource', api_action: 'GET /something', description: 'custom')

    api_version = ApiVersion.new(api_host: ApiHost.new(name: 'test.some.host'), name: 'v0')
    api_version.clear!

    assert_equal ApiExample.count, 0
    assert_equal ApiActionDescription.count, 0
  end
end
