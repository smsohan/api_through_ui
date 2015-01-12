class ApiAction
  include ActiveModel::Model
  attr_accessor :name, :api_resource

  delegate :api_host, :api_version, to: :api_resource

  def api_examples
    @api_examples ||= api_resource.api_examples.where(action: name)
  end

  def query_parameters
    queries = api_examples.distinct(:query).reduce(Hash.new([])) do |combined_queries, query|

      query.each_pair do |key, value|
        combined_queries[key] |= [value]
      end
      combined_queries
    end

    queries.map do |key, values|
      QueryParameter.new(name: key, example_values: values)
    end
  end

  def description
    options = {api_host: api_host.name,
      api_version: api_version.name,
      api_resource: api_resource.name,
      api_action: name}

    ApiActionDescription.where(options).first ||
    ApiActionDescription.new(options.merge(description: default_description))
  end

  def default_description
    description = []

    parameters = query_parameters
    if parameters.any?
      description << "### Query Parameters"
      description << ""

      description << "|Name|Type|Example Values|Description|"
      description << "|----|----|----|----|"
      description += query_parameters.map(&:to_markdown)
    end

    response_fields = api_examples.sort_by{|ex| -ex.stripped_response_body.length}.first.response_fields_summary_to_markdown
    if response_fields.present?
      description << "### Response Fields"
      description << ""

      description += response_fields
    end


    description.present? ? description.join("\n") : 'No description given'
  end

end