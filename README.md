[![Gem Version](https://badge.fury.io/rb/axiom-types.png)][gem]
[![Build Status](https://secure.travis-ci.org/dkubb/axiom-types.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dkubb/axiom-types.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dkubb/axiom-types.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/dkubb/axiom-types/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/axiom-types
[travis]: https://travis-ci.org/dkubb/axiom-types
[gemnasium]: https://gemnasium.com/dkubb/axiom-types
[codeclimate]: https://codeclimate.com/github/dkubb/axiom-types
[coveralls]: https://coveralls.io/r/dkubb/axiom-types

axiom-types
===========

Define types with optional constraints for use within axiom and other libraries.

Examples
--------

```ruby
# Setup constraints for all defined types
Axiom::Types.finalize

# Create Name subtype
Name = Axiom::Types::String.new do
  minimum_length 1
  maximum_length 30
end

# Test if the string is a member of the type
Name.include?('a')       # => true
Name.include?('a' * 30)  # => true
Name.include?('')        # => false
Name.include?('a' * 31)  # => false
```

Installation
------------

With Rubygems:

```bash
$ gem install axiom-types
$ irb -rubygems
>> require 'axiom-types'
=> true
```

With git and local working copy:

```bash
$ git clone git://github.com/dkubb/axiom-types.git
$ cd axiom-types
$ rake install
$ irb -rubygems
>> require 'axiom-types'
=> true
```

Contributing
-------------

* If you want your code merged into the mainline, please discuss the proposed changes with me before doing any work on it. This library is still in early development, and the direction it is going may not always be clear. Some features may not be appropriate yet, may need to be deferred until later when the foundation for them is laid, or may be more applicable in a plugin.
* Fork the project.
* Make your feature addition or bug fix.
  * Follow this [style guide](https://github.com/dkubb/styleguide).
* Add specs for it. This is important so I don't break it in a future version unintentionally. Tests must cover all branches within the code, and code must be fully covered.
* Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Run "rake ci". This must pass and not show any regressions in the metrics for the code to be merged.
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright &copy; 2013 Dan Kubb. See LICENSE for details.
