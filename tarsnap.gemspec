# frozen_string_literal: true

require_relative "lib/tarsnap/version"

Gem::Specification.new do |spec|
  spec.name          = "tarsnap"
  spec.version       = Tarsnap::VERSION
  spec.authors       = ["Michael Meckler"]
  spec.email         = ["rattroupe@reiterate-app.com"]

  spec.summary       = "Wrapper for tarsnap activities"
  spec.homepage      = "https://reiterate.app"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|bin)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"

  spec.add_development_dependency "byebug"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
