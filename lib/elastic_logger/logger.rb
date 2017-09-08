module ElasticLogger
  class Logger
    def initialize(name)
      @name = name.to_s
    end

    def log(hash)
      writer.log(hash)
    end
    alias_method :debug, :log
    alias_method :info, :log
    alias_method :warn, :log

    private
    attr_reader :name

    def writer
      writer = logs.fetch(name, default).fetch("writer")
      Object.const_get(writer).new(name: name, config: config)
    end

    def config
      @config ||= ElasticLogger.configuration
    end

    def logs
      @@logs ||= YAML.load_file(config.types_file)
    end

    def default
      { "writer" => "ElasticLogger::NullLogger" }
    end
  end
end
