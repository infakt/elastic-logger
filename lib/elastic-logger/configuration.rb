module ElasticLogger
  class Configuration
    attr_accessor :host, :types_file, :path

    def initialize
      @host = 'localhost:9200'
      @types_file = 'config/elastic_log_types.yml'
      @path = 'log'
    end
  end
end
