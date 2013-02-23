# encoding: utf-8

require File.expand_path('../lib/axiom/types/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name             = 'axiom-types'
  gem.version          = Axiom::Types::VERSION.dup
  gem.authors          = ['Dan Kubb']
  gem.email            = 'dan.kubb@gmail.com'
  gem.description      = 'Abstract types for logic programming'
  gem.summary          = gem.description
  gem.homepage         = 'https://github.com/dkubb/axiom-types'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md TODO]

  gem.add_runtime_dependency('backports',           '~> 2.8.2')
  gem.add_runtime_dependency('descendants_tracker', '~> 0.0.1')
  gem.add_runtime_dependency('ice_nine',            '~> 0.7.0')

  gem.add_development_dependency('rake',  '~> 10.0.3')
  gem.add_development_dependency('rspec', '~> 1.3.2')
  gem.add_development_dependency('yard',  '~> 0.8.4.1')
end
