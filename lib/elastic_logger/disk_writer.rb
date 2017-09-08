module ElasticLogger
  class DiskWriter
    def initialize(name:, config:)
      @config = config
      @name = name
    end

    def log(hash)
      logger.info(hash)
    end

    private
    attr_reader :config, :name

    def logger
      @logger ||= ::Logger.new(path_with(name), 'monthly').tap { |lgger|
        lgger.formatter = lambda { |_, _, _, msg| msg.to_h.to_json + "\n" }
      }
    end

    def path_with(name)
      Pathname.new(config.path).join("#{name}.log")
    end
  end
end
