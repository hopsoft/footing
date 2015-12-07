[![Lines of Code](http://img.shields.io/badge/lines_of_code-87-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](http://img.shields.io/codeclimate/github/hopsoft/footing.svg?style=flat)](https://codeclimate.com/github/hopsoft/footing)
[![Dependency Status](http://img.shields.io/gemnasium/hopsoft/footing.svg?style=flat)](https://gemnasium.com/hopsoft/footing)
[![Build Status](http://img.shields.io/travis/hopsoft/footing.svg?style=flat)](https://travis-ci.org/hopsoft/footing)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/footing.svg?style=flat)](https://coveralls.io/r/hopsoft/footing?branch=master)
[![Downloads](http://img.shields.io/gem/dt/footing.svg?style=flat)](http://rubygems.org/gems/footing)

# Footing

An [ActiveSupport](https://github.com/rails/rails/tree/master/activesupport)
style utility library that employs [delegation](https://en.wikipedia.org/wiki/Delegation_(programming))
instead of [monkey patching](https://en.wikipedia.org/wiki/Monkey_patch).

__NOTE:__ _The project is structured so that it can support explicit monkey patching if you prefer to use that strategy._

## Immutabilty

Footing employs some principles of [immutability](https://en.wikipedia.org/wiki/Immutable_object) that are common in
[functional programming](https://en.wikipedia.org/wiki/Functional_programming).
The integrity of original objects/data is preserved because Footing creates a deep copy by default.

__NOTE:__ _This behavior can be overridden to improve performance... just be sure you know what you're doing_

## Hash

### Filter

Recursively filter out unwanted values based on key.

```ruby
data = { name: "Joe", password: "secret" }
copy = Footing::Hash.new(data)
copy.filter!(:password)
copy.inner_object # => {:name=>"Joe", :password=>"[FILTERED]"}
```
