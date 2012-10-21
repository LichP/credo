require './lib/credo/version'

Gem::Specification do |s|
  s.name = "credo"
  s.version = Credo::VERSION
  s.summary = %{A simple way to retain and use credentials}
  s.description = %Q{Credo provides a mechanism for storing credentials for situations where more desirable mechanisms (i.e. OAuth) are unavailable.}
  s.authors = ['Phil Stewart']
  s.email = ['phil.stewart@lichp.co.uk']
  s.homepage = 'http://github.com/lichp/credo'
  
  s.files = Dir [
    'lib/**/*.rb',
    'test/*.rb',
    'README',
    'LICENSE',
    'Rakefile'
  ]
  
  s.add_dependency 'encryptor'
  s.add_dependency 'highline'
end
