# Footing

#### NOTE: this lib is experimental at the moment

This lib extends native objects with additional functionality.

## No implicit monkey patching

**No surprises here.** You must explicitly ask for Footing goodness to be added to your objects.

```ruby
# some examples of explicit patching
Footing.patch!(String)
String.ancestors
[
  String,
  Footing::String::InstanceMethods,
  Comparable,
  Object,
  PP::ObjectMixin,
  Kernel,
  BasicObject
]

Footing.patch!(Numeric)
[
  Numeric,
  Footing::Numeric::InstanceMethods,
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
Footing.patch!(s)
s.respond_to? :escape # => true
"foo".respond_to? :escape # => false
```

## Kick the tires

* `git clone git://github.com/hopsoft/footing.git`
* `cd /path/to/footing`
* `bundle`
* `./console`
* `Footing.patch(String)`
