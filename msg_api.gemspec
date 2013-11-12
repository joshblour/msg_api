$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "msg_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "msg_api"
  s.version     = MsgApi::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MsgApi."
  s.description = "TODO: Description of MsgApi."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency 'her'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'request_store'
  

  s.add_development_dependency "sqlite3"
end
