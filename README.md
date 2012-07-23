# Footing

#### NOTE: this lib is experimental at the moment

Footing provides some sanity for monkey patching practices.
It's also a utility lib that contains additional functionality for core objects that you might find useful.

## No implicit monkey patching

**No surprises here.** You must explicitly patch.

```ruby
# some examples of explicit patching
Footing.patch! String, Footing::String
Footing.patch! Numeric, Footing::Numeric
```

```ruby
# instrospect the changes
String.ancestors
[
  String,
  Footing::String::InstanceMethods,
  Footing::String,
  Comparable,
  Object,
  Kernel,
  BasicObject
]

Numeric.ancestors
[
  Numeric,
  Footing::Numeric::InstanceMethods,
  Footing::Numeric,
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
s.respond_to? :escape # => true
"foo".respond_to? :escape # => false
```

## Shotgun patching

For the lazy and brave, you can also patch everything at once.

```ruby
Footing.patch_all!
```

## Kick the tires

* `git clone git://github.com/hopsoft/footing.git`
* `cd /path/to/footing`
* `bundle`
* `./console`
* `Footing.patch String, Footing::String`
