require_relative 'lib/travel_guides/version'

Gem::Specification.new do |spec|
  spec.name          = "travel_guides"
  spec.version       = TravelGuides::VERSION
  spec.authors       = ["rschlosser11"]
  spec.email         = ["rosalinschlosser@gmail.com"]

  spec.summary       = %q{Travel guides for different countries.}
  spec.description   = %q{Shows you the various reasons you should visit different countries/states as provided by worldtravelguide.net.}
  spec.homepage      = "https://github.com/rschlosser11/travel_guides"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rschlosser11/travel_guides"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
