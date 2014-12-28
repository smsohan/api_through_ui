class ApiAction
  include ActiveModel::Model
  attr_accessor :name, :api_resource

  delegate :api_host, :api_version, to: :api_resource

  def api_examples
    api_resource.api_examples.where(action: name)
  end
end