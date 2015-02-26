# encoding: utf-8

source 'https://rubygems.org'

gemspec

platforms :rbx do
  gem 'rubysl-bigdecimal', '~> 2.0.2'
end

group :development, :test do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git',
                  branch: 'c87e653f66d282447d7c108493d416d181340d55'
end

eval_gemfile 'Gemfile.devtools'
