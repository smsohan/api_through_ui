class ApiHost

  include ActiveModel::Model
  attr_accessor :name

  def self.all
    ApiExample.distinct(:host).map{|host| new(name: host)}
  end

  def versions
    api_examples.distinct(:version).map{|version| ApiVersion.new(name: version, api_host: self)}
  end

  def api_examples
    ApiExample.where(host: name)
  end

end
