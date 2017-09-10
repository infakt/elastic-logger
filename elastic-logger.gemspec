lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastic_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "elastic-logger"
  spec.version       = ElasticLogger::VERSION
  spec.authors       = ["Radosław Woźnik", "Infakt DevTeam"]
  spec.email         = ["p@infakt.pl"]

  spec.summary       = %q{Elastic Logger, logs to elasticsearch or files}
  spec.description   = %q{Elastic Logger, logs to elasticsearch or files}
  spec.homepage      = "https://github.com/infakt/elastic-logger"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['elastic_logger']
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_dependency "elasticsearch"
end
