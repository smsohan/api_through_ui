class ApiResource
  include ActiveModel::Model

  attr_accessor :name, :api_version

  delegate :api_host, to: :api_version

  def api_examples
    api_version.api_examples.where(resource: name)
  end

  def api_actions
    api_examples.distinct(:action).map{|action| ApiAction.new(name: action, api_resource: self)}
  end

end