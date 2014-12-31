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
        combined_queries[key] += [value]
      end
      combined_queries
    end

    queries.map do |key, values|
      QueryParameter.new(name: key, example_values: values)
    end
  end

end