class ApiExample
  include Mongoid::Document

  field :host, type: String
  field :url, type: String
  field :fullURL, type: String, as: :full_url
  field :http_method, type: String
  field :version, type: String
  field :resource, type: String
  field :description, type: String
  field :query, type: Hash, default: {}
  field :requestHeaders, type: Hash, as: :request_headers
  field :requestBody, type: String, as: :request_body
  field :responseHeaders, type: Hash, as: :response_headers
  field :responseBody, type: String, as: :response_body
  field :strippedResponseBody, type: String, as: :stripped_response_body
  field :recordedAt, type: DateTime, as: :recorded_at
  field :requiresAuth, type: Boolean, as: :requires_auth, default: false

  SPYREST_HEADER_PREFIX = 'x-spy-rest-'

  def request_headers_without_spyrest
    request_headers.reduce({}) do |hash, (key, value)|
      hash[key] = value unless key.starts_with?(SPYREST_HEADER_PREFIX)
      hash
    end
  end

  def to_curl
    curl_headers_string = request_headers_without_spyrest.map{|key, value| "-H '#{key}: #{value}'"}.join(" \\\n")
    curl_parts = ["curl -k"]
    curl_parts << "-X #{http_method}"
    curl_parts << curl_headers_string
    curl_parts << "-d '#{request_body}'" if request_body.present?
    curl_parts << "'#{full_url}'"

    curl_parts.join(" \\\n")
  end

  def response_fields_summary_to_markdown
    Markdownizer.to_md(JSON.parse(stripped_response_body))
  rescue
    []
  end

  def prettified_response
    JSON.pretty_generate(JSON.parse(stripped_response_body))
  rescue
    stripped_response_body
  end

end
