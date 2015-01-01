class ApiExample
  include Mongoid::Document

  field :host, type: String
  field :url, type: String
  field :http_method, type: String
  field :version, type: String
  field :resource, type: String
  field :description, type: String
  field :query, type: Hash, default: {}
  field :requestHeaders, type: Hash, as: :request_headers
  field :requestBody, type: String, as: :request_body
  field :responseHeaders, type: Hash, as: :response_headers
  field :responseBody, type: String, as: :response_body
  field :recordedAt, type: DateTime, as: :recorded_at

  def prettified_response
    JSON.pretty_generate(JSON.parse(response_body))
  rescue
    response_body
  end

  def to_curl
    curl_headers = request_headers.merge( 'x-spy-rest-desc' => description,
      'x-spy-rest-resource' => resource,
      'x-spy-rest-version' => version
       )

    curl_headers_string = curl_headers.map{|key, value| "-H '#{key}: #{value}'"}.join(" \\\n")

    "curl -k -x 'http://spyrest.com:9081' \\\n#{curl_headers_string} \\\n'https://api.github.com#{url}'"
  end
end
