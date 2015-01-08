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

  SPYREST_HEADER_PREFIX = 'x-spy-rest-'

  def request_headers_without_spyrest
    request_headers.reduce({}) do |hash, (key, value)|
      hash[key] = value unless key.starts_with?(SPYREST_HEADER_PREFIX)
      hash
    end
  end

  def to_curl
    curl_headers_string = request_headers_without_spyrest.map{|key, value| "-H '#{key}: #{value}'"}.join(" \\\n")
    curl_parts = ["curl -k -x 'http://spyrest.com:9081'"]
    curl_parts << "-X #{http_method}"
    curl_parts << curl_headers_string
    curl_parts << "-d '#{request_body}'" if request_body.present?
    curl_parts << "'#{full_url}'"

    curl_parts.join(" \\\n")
  end

  def response_fields_summary_to_markdown
    response_fields_summary.map do |response_field|
      key = response_field[0].present? ? "`#{response_field[0]}`" : ''
      "|#{key}|#{response_field[1]}||"
    end
  end

  def response_fields_summary
    response_fields('', JSON.parse(stripped_response_body))
  end

  def response_fields(key, value)
    if !value.is_a?(Hash) && !value.is_a?(Array)
      value_class = case
      when value.is_a?(TrueClass)
        'Boolean'
      when value.is_a?(FalseClass)
        'Boolean'
      when value.is_a?(Integer)
        'Integer'
      else
        value.class.to_s
      end

      return [[key, value_class]]
    end

    if value.is_a?(Hash)
      result = []
      value.each do |item_key, item_value|
        flattened_key = key.present? ? "#{key}.#{item_key}" : "#{item_key}"
        result += response_fields(flattened_key, item_value)
      end
      return result
    end

    if value.is_a?(Array)
      base = [[key, Array.to_s]]
      value.first.try(:tap) do |item|
        base += response_fields("#{key}[]", item)
      end

      return base
    end

  end

end
