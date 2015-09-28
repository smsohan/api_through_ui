class ApiVersion
  include ActiveModel::Model

  attr_accessor :name, :api_host

  def api_examples
    api_host.api_examples.where(version: name)
  end

  def api_resources
    api_examples.distinct(:resource).map{|resource| ApiResource.new(name: resource, api_version: self)}
  end

  def export
    file_index = 0
    export_to_file = Proc.new do |zipfile, model|
      file_index += 1
      zipfile.get_output_stream("export-#{file_index}.json") do |os|
        os.write model.to_json(root: true)
      end
    end

    zipfile_path = Tempfile.new("export-#{api_host.name}-#{name}.zip").path

    Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
      api_resources.each do |resource|
        resource.api_actions.each do |action|
          description = action.custom_description
          export_to_file[zipfile, action.custom_description] if description
          action.api_examples.each do |example|
            export_to_file[zipfile, example]
          end
        end
      end
    end

    zipfile_path
  end

  def self.import(destination_host, zip_file_path)
    Zip::File.open(zip_file_path) do |zip_file|

      zip_file.each do |entry|
        json_content = entry.get_input_stream.read
        hash = JSON.parse(json_content)
        if hash.has_key?('api_example')
          hash['api_example'].delete('_id')
          ApiExample.new(hash['api_example'].merge('host' => destination_host)).save!
        end
      end
    end
  end

end