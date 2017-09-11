ElasticLogger.configure do |config|
  config.host = '192.168.60.10:9200'
  config.types_file = 'config/elastic_log_types.yml'
  config.path = 'log'
end
