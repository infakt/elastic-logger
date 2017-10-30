module ElasticLogger
  class Types
    def all
      logs
    end

    def by_writter(writer)
      logs.select { |_, values| values.fetch("writer") == writer }
    end

    def find(name)
      logs.fetch(name, default)
    end

    private

    def logs
      @@logs ||= YAML.load_file(config.types_file)
    end

    def config
      ElasticLogger.configuration
    end

    def default
      { "writer" => "ElasticLogger::NullLogger", "level" => "debug" }
    end
  end
end
