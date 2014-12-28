class ApiExample
  include Mongoid::Document

  field :host, type: String
  field :url, type: String
  field :http_method, type: String
  field :version, type: String
end
