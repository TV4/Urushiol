# encoding: utf-8

$:.push File.expand_path("./lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'urushiol'
  s.version     = '0.6'
  s.date        = '2013-09-23'
  s.required_ruby_version = ">=1.9.3"
  s.authors     = ["TV4","Karl Litterfeldt"]
  s.email       = "karl.litterfeldt@tv4.se"
  s.license     = "MIT-LICENSE"

  s.homepage    = "http://www.tv4.se"
  s.summary     = %q{Test framework written in Ruby to test varnish-cache routing and caching logic.}
  s.description = %q{Urushiol was born out of necessity. When we decided to migrate our reverse proxy routing from Apache to Varnish we noticed that this would not be a trivial matter. As the migration came to a halt due to unexpected routing errors we decided that, having a proper way of testing our configs would not be a bad idea. Urushiol is the product of that idea.}

  s.files       = Dir.glob("lib/**/*") + %w(urushiol.gemspec LICENSE README.md)
end
