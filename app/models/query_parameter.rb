class QueryParameter

  include ActiveModel::Model

  attr_accessor :name, :example_values, :required

  def example_values
    @example_values || []
  end

  def type_name
    example_value = example_values.first
    return 'Integer' if integer?(example_value)
    return 'Float' if float?(example_value)
    return 'DateTime' if datetime?(example_value)
    return 'Date' if date?(example_value)
    return 'Date' if boolean?(example_value)
    return 'String'
  end

  def to_markdown
    examples = example_values.join(", ")
    '|' + ["`#{name}`", type_name, examples, ''].join('|') + '|'
  end

  private

  def integer?(value)
    value.to_i.to_s == value
  end

  def float?(value)
    value.to_i.to_s == value
  end

  def datetime?(value)
    value.to_time
  rescue
    false
  end

  def date?(value)
    value.to_date
  rescue
    false
  end

  def boolean?(value)
    ['true', 'false'].include?(value.downcase)
  rescue
    false
  end

end