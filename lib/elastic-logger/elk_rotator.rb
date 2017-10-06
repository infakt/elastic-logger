require 'elasticsearch'
require 'elastic-logger/types'

module ElasticLogger
  class ElkRotator
    def rotate
      logs.each do |name, value|
        hash = value.select { |k,v| keys.include?(k) }
        client.index(index: index, type: index, id: name, body: hash)
      end
    end

    private

    def logs
      @logs ||= ElasticLogger::Types.new.by_writter('ElasticLogger::ElkWriter')
    end

    def client
      @client ||= Elasticsearch::Client.new(host: config.host)
    end

    def config
      ElasticLogger.configuration
    end

    def index
      'elastic_logger_rotate'
    end

    def keys
      ["rotate_type", "rotate", "backup"]
    end
  end
end
