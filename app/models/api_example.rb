class ApiExample
  include Mongoid::Document

  field :host, type: String
  field :url, type: String
  field :action, type: String
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
  field :userId, type: String, as: :user_id

  include Mongoid::Attributes::Dynamic

  belongs_to :user

  SPYREST_HEADER_PREFIX = 'x-spy-rest-'

  def request_headers_without_spyrest
    request_headers.reduce({}) do |hash, (key, value)|
      hash[key] = value unless key.starts_with?(SPYREST_HEADER_PREFIX) || %w{host connection}.include?(key)
      hash
    end
  end

  def to_curl
    curl_headers_string = request_headers_without_spyrest.map{|key, value| "-H '#{key}: #{value}'"}.join(" \\\n")
    curl_parts = ["curl -X #{http_method}"]
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

  def stripped?
    strippedResponseBody.present?
  end

  def prettified_json(json)
    JSON.pretty_generate(JSON.parse(json))
  rescue
    json
  end

  def prettified_stripped_response
    prettified_json(stripped_response_body)
  end

  def prettified_response
    prettified_json(response_body)
  end

end
