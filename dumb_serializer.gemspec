# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name = 'dumb_serializer'
  s.version = '0.0.0'
  s.date = '26.10.2015'
  s.description = 'Mongo mapper for ruby objects.'
  s.authors = ['Robert Pawlas']
  s.email = 'robspawlas@gmail.com'
  s.files = ['lib/dumb_serializer/attrs_scanner.rb', 'lib/dumb_serializer/mongo_connector.rb',
             'lib/dumb_serializer/serializable.rb', 'lib/dumb_serializer/destroyable.rb',
             'lib/dumb_serializer/loadable.rb', 'lib/dumb_serializer.rb']
  s.homepage = ''
  s.license = 'MIT'
end
