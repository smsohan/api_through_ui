class QueryParameter

  include ActiveModel::Model

  attr_accessor :name, :example_values

  INTEGER_REGEX = /^\d+$/
  NUMBER_REGEX = /^\-?\d*\.?\d*+$/

  def example_values
    @example_values || []
  end

end