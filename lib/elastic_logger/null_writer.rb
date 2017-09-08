module ElasticLogger
  class NullLogger
    def initialize(name:, config:); end
    def log(hash); end
  end
end
