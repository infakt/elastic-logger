module ElasticLogger
  class DiskWriter
    def initialize(name:, config:)
      @config = config
      @name = name
    end

    def log(severity, hash)
      logger.send(severity, build_log(hash))
    end

    private
    attr_reader :config, :name

    def build_log(hash)
      hash.merge("@timestamp" => timestamp.iso8601(3))
    end

    def logger
      @logger ||= ::Logger.new(path_with(name), 'monthly').tap { |lgger|
        lgger.formatter = lambda { |_, _, _, msg| msg.to_h.to_json + "\n" }
      }
    end

    def path_with(name)
      Pathname.new(config.path).join("#{name}.log")
    end

    def timestamp
      Time.now.utc
    end
  end
end
