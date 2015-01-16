class Markdownizer
  def self.to_md(hash)
    header = "|Name|Type|Description|"
    header_separator = "|---|---|---|"

    markdown_rows = [header, header_separator]
    markdown_rows += to_md_rows(hash)
  end


  private

  def self.simple_type_to_md_row(value, key)
    value_class = case
    when value.is_a?(TrueClass)
      'Boolean'
    when value.is_a?(FalseClass)
      'Boolean'
    when value.is_a?(Integer)
      'Integer'
    when value.is_a?(NilClass)
      ''
    when value.is_a?(Array)
      Array.to_s
    else
      is_date?(value) ? 'String (Time ISO8601)' : value.class.to_s
    end

    return ["|#{key}|#{value_class}||"]
  end

  def self.is_date?(value)
    Time.iso8601(value)
  rescue
    false
  end

  def self.to_md_rows(value, key = nil)
    if !value.is_a?(Hash) && !value.is_a?(Array)
      return simple_type_to_md_row(value, key)
    end

    if value.is_a?(Hash)
      return value.map do |item_key, item_value|
        flattened_key = key.present? ? "#{key}.#{item_key}" : "#{item_key}"
        to_md_rows(item_value, flattened_key)
      end.flatten
    end

    array_rows = simple_type_to_md_row(value, key)
    if value.first
      array_rows += to_md_rows(value.first, "#{key}[]")
    end

    array_rows
  end
end