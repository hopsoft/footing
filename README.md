# Footing

[![Lines of Code](http://img.shields.io/badge/loc-287-brightgreen.svg)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](https://codeclimate.com/github/hopsoft/footing.png)](https://codeclimate.com/github/hopsoft/footing)
[![Dependency Status](https://gemnasium.com/hopsoft/footing.png)](https://gemnasium.com/hopsoft/footing)
[![Build Status](https://travis-ci.org/hopsoft/footing.png)](https://travis-ci.org/hopsoft/footing)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/footing.svg)](https://coveralls.io/r/hopsoft/footing?branch=master)

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

