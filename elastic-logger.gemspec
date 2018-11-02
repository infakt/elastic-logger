lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastic-logger/version'

Gem::Specification.new do |spec|
  spec.name          = "elastic-logger"
  spec.version       = ElasticLogger::VERSION
  spec.authors       = ['Radosław Woźniak', 'Infakt DevTeam']
  spec.email         = ['p@infakt.pl']

  spec.summary       = %q{Elastic Logger, logs to elasticsearch or files}
  spec.description   = %q{Elastic Logger, logs to elasticsearch or files}
  spec.homepage      = 'https://github.com/infakt/elastic-logger'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_dependency 'elasticsearch', '~> 6.0'
end
