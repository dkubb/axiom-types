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
end
