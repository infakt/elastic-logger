require 'elasticsearch'

module ElasticLogger
  class ElkWriter
    def initialize(name:, config:)
      @config = config
      @name = name
    end

    def log(severity, hash)
      client.index(index: index, type: name, body: build_log(severity, hash))
    end

    private
    attr_reader :config, :name

    def build_log(severity, hash)
      {
        "@fields" => hash,
        "@timestamp" => timestamp.iso8601(3),
        "@severity" => severity
      }
    end

    def client
      @client ||= Elasticsearch::Client.new(host: config.host)
    end

    def index
      "#{name}-#{timestamp.strftime('%Y.%m.%d')}"
    end

    def timestamp
      Time.now.utc
    end
  end
end
