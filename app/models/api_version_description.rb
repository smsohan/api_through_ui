class ApiVersionDescription
  include Mongoid::Document

  field :api_host, type: String
  field :api_version, type: String
  field :description, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  validates :api_host, presence: true
  validates :api_version, presence: true
  validates :description, presence: true

  index({api_host: 1, api_version: 1}, unique: true)

  before_save :strip_carriage_returns

  def self.new_for_resource(api_version)
    api_action_description = new(api_host: api_version.api_host.name,
      api_version: api_version.name)
  end

  def strip_carriage_returns
    description.delete!("\r")
  end

end