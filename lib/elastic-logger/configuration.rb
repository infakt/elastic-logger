module ElasticLogger
  class Configuration
    attr_accessor :host, :types_file, :path, :prefix, :log_level

    def initialize
      @host = 'localhost:9200'
      @types_file = 'config/elastic_log_types.yml'
      @path = 'log'
      @prefix = ''
      @log_level = ::Logger::DEBUG
    end
  end
end
