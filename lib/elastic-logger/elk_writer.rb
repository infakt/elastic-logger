module ElasticLogger
  class ElkWriter
    def initialize(name:, config:)
      @config = config
      @name = name
    end

    def log(hash)
      client.index(index: index, type: name, body: hash)
    end

    private
    attr_reader :config, :name

    def client
      @client ||= Elasticsearch::Client.new(host: config.host)
    end

    def index
      "#{name}-#{Date.today.strftime('%Y.%m.%d')}"
    end
  end
end
