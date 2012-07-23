# Hopsoft utility lib

#### NOTE: this lib is experimental at the moment

This lib extends native objects with additional functionality.

## No implicit monkey patching

**No surprises here.** You must explicitly ask for Hopsoft goodness to be added to your objects.

```ruby
# some examples of explicit patching
Hopsoft.patch(String)
Hopsoft.patch(Numeric)
```

## Instance patching

If you don't want to corrupt your entire runtime, you can choose to patch an instance.

```ruby
s = "foo"
Hopsoft.patch(s)
s.respond_to? :escape # => true

"foo".respond_to? :escape # => false
```

## Kick the tires

* `git clone git://github.com/hopsoft/hopsoft.git`
* `cd /path/to/hopsoft`
* `bundle`
* `./console`
* `Hopsoft.patch(String)`
