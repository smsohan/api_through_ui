json.array!(@api_examples) do |api_example|
  json.extract! api_example, :id, :host, :url, :http_method
  json.url api_example_url(api_example, format: :json)
end
