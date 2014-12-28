class ApiExample
  include Mongoid::Document

  field :host, type: String
  field :url, type: String
  field :http_method, type: String
  field :version, type: String
  field :requestHeaders, type: Hash, as: :request_headers
  field :requestBody, type: String, as: :request_body
  field :responseHeaders, type: Hash, as: :response_headers
  field :responseBody, type: String, as: :response_body
end
