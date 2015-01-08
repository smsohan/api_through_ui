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
    parameters = query_parameters

    if parameters.any?
      description = ["### Query Parameters"]

      description << "|Name|Type|Example Values|Description|"
      description << "|----|----|----|----|"

      description += query_parameters.map do |query_parameter|
        examples = query_parameter.example_values.join(", ")
        '|' + ["`#{query_parameter.name}`", query_parameter.type_name, examples, ''].join('|') + '|'
      end

      description.join("\n")
    else
      'No description given'
    end
  end

end