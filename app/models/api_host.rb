class ApiHost

  include ActiveModel::Model
  attr_accessor :name

  def self.all
    ApiExample.distinct(:host).map{|host| new(name: host)}
  end

  def versions
    ApiExample.where(host: name).distinct(:version).map{|version| ApiVersion.new(name: version, api_host: self)}
  end

end