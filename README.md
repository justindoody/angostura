# Angostura Dependency Gem

![Angostura Leaf](http://i.imgur.com/gHIhrzU.png)

Angostura adds an easy way to setup component dependencies.

## Great, how do I use it?

The simplest usage just sets a few dependencies by including angostura and using the `dependendency` hook with an arg or two.

```ruby
module GreatComponent
  include Angostura::Dependencies

  dependency :user, :authorizer
end
```

With this `GreatComponent` now responds to `GreatComponent.user` and `GreatComponent.user_class`.

`GreatComponent` also now has an available setup method to be used in an initializer.

```ruby
GreatComponent.setup do |config|
  config.user = 'PoorChoices'
end
```

Config expects stringified class names, angostura will dynamically define a dependency_class method for you which returns the constantized class.

The `dependency` hook also allows you to set defaults for the dependency by passing keyword arguments. For example `dependency :house, car: 'Mazerati'`, a dependency with a default can still of course be overriden in the setup block.

### That's it, that's all. It's a simple small gem.
