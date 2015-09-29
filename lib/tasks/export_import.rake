namespace :data do

  task :export, [:api_host, :api_version] => :environment do |api_host, api_version|
    api_host = ApiHost.new(name: api_host)
    api_version = ApiVersion.new(api_host: api_host, name: api_version)
    exported = api_version.export
    puts "Exported: #{exported}"
  end

  task :import, [:api_host, :exported_file] => :environment do |api_host, exported_file|
    api_version = ApiVersion.import(api_host, exported_file)
  end

  task :clear, [:api_host, :api_version] => :environment do |api_host, api_version|
    api_host = ApiHost.new(name: api_host)
    api_version = ApiVersion.new(api_host: api_host, name: api_version)
    api_version.clear!
  end

end