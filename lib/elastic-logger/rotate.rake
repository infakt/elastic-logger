namespace :elastic_logger do
  desc "Sends rotate info to kibana"
  task :rotate do
    ElasticLogger::ElkRotator.new.rotate
  end
end
