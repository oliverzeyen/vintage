Gem::Specification.new do |s|
  s.name      = 'vintage'
  s.version   = `cat #{File.dirname(__FILE__)}/VERSION`
  s.authors   = ['Oliver Zeyen']
  s.email     = ['oliver.zeyen@solarisbank.de']
  s.homepage  = 'https://github.com/solarisBank/vintage'
  s.summary   = 'A straight-to-swagger grape extractor'
  s.description = 'Swagger object and schema representation in ruby extracting and converting grape endpoints and entities straight to swagger.json'
  s.files     = `git ls-files | grep lib`.split("\n")
  s.license   = 'MIT'

  #s.add_dependency 'addressable'

  s.add_development_dependency 'grape'
  s.add_development_dependency 'grape-entity', '~> 0.5'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rake', '>= 0.9.2'
  s.add_development_dependency 'rspec'
end
