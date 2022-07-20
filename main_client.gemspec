require_relative "lib/main_client/version"

Gem::Specification.new do |s|
  s.name = "main_client"
  s.version = MainClient::VERSION
  s.authors = ["yarzar"]
  s.email = ["yarzarminwai97@gmail.com"]

  s.summary     = "Holds in one place all the gubbins necessary to act as a client to the Croucher main system."
  s.description = "For now just a convenience and maintenance simplifier."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"

  s.add_development_dependency "sqlite3"
end
