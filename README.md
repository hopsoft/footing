# Hopsoft utility lib

This lib extends native objects with additional functionality.

## No implicit monkey patching

**No surprises here.** You must explicitly ask for the goodness to be added to your objects.

```ruby
# some examples of explicit patching
Hopsoft.patch(String)
Hopsoft.patch(Numeric)
```
