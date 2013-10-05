# encoding: utf-8

require File.expand_path('../lib/axiom/types/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'axiom-types'
  gem.version     = Axiom::Types::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = 'dan.kubb@gmail.com'
  gem.description = 'Abstract types for logic programming'
  gem.summary     = 'Define types with optional constraints for use within axiom and other libraries.'
  gem.homepage    = 'https://github.com/dkubb/axiom-types'
  gem.license     = 'MIT'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/unit`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]

  gem.add_dependency('descendants_tracker', '~> 0.0.1')
  gem.add_dependency('ice_nine',            '~> 0.9')

  gem.add_development_dependency('bundler', '~> 1.3', '>= 1.3.5')
end
