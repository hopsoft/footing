# Hopsoft

#### NOTE: this lib is experimental at the moment

This lib extends native objects with additional functionality.

## No implicit monkey patching

**No surprises here.** You must explicitly ask for Hopsoft goodness to be added to your objects.

```ruby
# some examples of explicit patching
Hopsoft.patch!(String)
String.ancestors
[
  String,
  Hopsoft::String::InstanceMethods,
  Comparable,
  Object,
  PP::ObjectMixin,
  Kernel,
  BasicObject
]

Hopsoft.patch!(Numeric)
[
  Numeric,
  Hopsoft::Numeric::InstanceMethods,
  Comparable,
  Object,
  PP::ObjectMixin,
  Kernel,
  BasicObject
]
```

## Instance patching

If you don't want to corrupt your entire runtime, you can patch an instance.

```ruby
s = "foo"
Hopsoft.patch!(s)
s.respond_to? :escape # => true
"foo".respond_to? :escape # => false
```

## Kick the tires

* `git clone git://github.com/hopsoft/hopsoft.git`
* `cd /path/to/hopsoft`
* `bundle`
* `./console`
* `Hopsoft.patch(String)`
