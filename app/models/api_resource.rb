class ApiResource
  include ActiveModel::Model

  attr_accessor :name, :api_version

  def api_examples
    api_version.api_examples.where(resource: resource)
  end

end