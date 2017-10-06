namespace :elastic_logger do
  desc "Sends rotate info to kibana"
  task rotate: :environment do
    ElasticLogger::ElkRotator.new.rotate
  end
end
