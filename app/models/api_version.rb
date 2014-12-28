class ApiVersion
  include ActiveModel::Model

  attr_accessor :name, :api_host

  def api_examples
    api_host.api_examples.where(version: name)
  end

  def api_resources
    api_examples.distinct(:resource).map{|resource| ApiResource.new(name: resource, api_version: self)}
  end

end