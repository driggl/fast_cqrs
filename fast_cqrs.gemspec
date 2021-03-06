# frozen_string_literal: true

require_relative 'lib/fast_cqrs/version'

Gem::Specification.new do |spec|
  spec.name          = 'fast_cqrs'
  spec.version       = FastCqrs::VERSION
  spec.authors       = ['Sebastian Wilgosz']
  spec.email         = ['sebastian@driggl.com']

  spec.summary       = 'A lightweight CQRS scaffold for ruby-based web applications.'
  spec.description   = 'Write CQRS applications easily using functional endpoints without a hassle.'
  spec.homepage      = 'https://github.com/driggl/fast_cqrs'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/driggl/fast_cqrs'
  spec.metadata['changelog_uri'] = 'https://github.com/driggl/fast_cqrs/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-matcher'
  spec.add_dependency 'dry-monads'
  spec.add_dependency 'dry-struct'
  spec.add_dependency 'dry-types'
  spec.add_dependency 'dry-validation'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
end
