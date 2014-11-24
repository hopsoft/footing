[![Lines of Code](http://img.shields.io/badge/lines_of_code-279-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](http://img.shields.io/codeclimate/github/hopsoft/footing.svg?style=flat)](https://codeclimate.com/github/hopsoft/footing)
[![Dependency Status](http://img.shields.io/gemnasium/hopsoft/footing.svg?style=flat)](https://gemnasium.com/hopsoft/footing)
[![Build Status](http://img.shields.io/travis/hopsoft/footing.svg?style=flat)](https://travis-ci.org/hopsoft/footing)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/footing.svg?style=flat)](https://coveralls.io/r/hopsoft/footing?branch=master)
[![Downloads](http://img.shields.io/gem/dt/coast.svg?style=flat)](http://rubygems.org/gems/footing)

# Footing

Footing provides some sanity for monkey patching practices.

It's also a utility lib that contains additional functionality for core objects that you might find useful.
Think of it as a lightweight version of ActiveSupport that doesn't implicitly change native behavior.

## No implicit monkey patching

You must explicitly apply monkey patches.

```ruby
Footing.patch! String, Footing::String
Footing.patch! Numeric, Footing::Numeric
```

Patches are visible in the classes ancestry.

```ruby
String.ancestors
[
  String,
  Footing::String, # <--
  Comparable,
  Object,
  Kernel,
  BasicObject
]

Numeric.ancestors
[
  Numeric,
  Footing::Numeric, # <--
  Comparable,
  Object,
  Kernel,
  BasicObject
]
```

## Instance patching

If you don't want to corrupt the entire runtime, you can patch an instance.

```ruby
s = "foo"
Footing.patch! s, Footing::String
s.respond_to? :escape     # => true
"foo".respond_to? :escape # => false
```

## Patch free

Dont like monkey patches? Run patch free by setting up utility methods instead.

```ruby
Footing.util! Footing::String
Footing::String.escape "foo", "o" # => "f\\o\\o"
```

## The Library

The suite of functionality is pretty small right now.
Poke around the [extensions directory](https://github.com/hopsoft/footing/tree/master/lib/footing/extensions) to see what's available.

Pull requests welcome.

