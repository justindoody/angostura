# Angostura Dependency Gem

![Angostura Leaf](http://i.imgur.com/gHIhrzU.png)

Angostura adds an easy way to setup component dependencies inspired by [rails engine setup guides](http://guides.rubyonrails.org/engines.html#configuring-an-engine).

Angostura expands upon the basic idea of using a `mattr_accessor` adding validation to ensure using stringified class names during setup, ensure that dependencies were set, and provide default values.

## Great, how do I use it?

The simplest usage just sets a few dependencies by including angostura and using the `dependendency` hook with an arg or two.

```ruby
module GreatComponent
  include Angostura::Dependencies

  dependency :user, :authorizer
end
```

With this `GreatComponent` now responds to `GreatComponent.user` returning the setup string and `GreatComponent.user_class` returning the class object.

`GreatComponent` also now has an available setup method to be used in an initializer.

```ruby
GreatComponent.setup do |config|
  config.user = 'PoorChoices'
end
```

Config expects stringified class names, angostura will dynamically define a dependency_class method for you which returns the constantized class.

The `dependency` hook also allows you to set defaults for the dependency by passing keyword arguments. For example `dependency :house, car: 'Mazerati'`, a dependency with a default can still of course be overriden in the setup block.

### That's it, that's all. It's a simple small gem.
