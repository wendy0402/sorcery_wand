# SorceryWand
Plugin for [sorcery](https://github.com/NoamB/sorcery) to add more feature than it already has in the core gem(sorcery). For now `sorcery_wand` only support `ActiveRecord`.

Currently it has additional module:
* `'password_archivable'`: Archive old password from user. user cannot change their current password with archived password.

# Installation
If using bundler, first add 'sorcery_wand' to your Gemfile:
```ruby
gem 'sorcery_wand', github: 'wendy0402/sorcery_wand' # not yet registered
```
And run
```
bundle install
```

# Rails Configuration
overall rails generator configuration:
```console
rails generate sorcery_wand:install [submodules] [options]

Options:
  --model-name=model_name  # model class name for sorcery
Submodules:
* password_archivable
```
below will generate `initializer` file, `password_archivable` related model class(if any)
```
rails generate sorcery_wand:install password_archivable --model-name User
```
Inside the initializer, there is brief explanation for each setting. Initializer is located in `config/initializer/sorcery_wand.rb`

Put `inject_sorcery_wand!` below `authenticates_with_sorcery!` in the model which name is declared in config `user_class`. `user_class` must be declared in initializer
```ruby
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  inject_sorcery_wand!
end
```


# Copyright
Copyright (c) 2015-2019 Wendy Kurniawan Soesanto([wendy0402](https://github.com/wendy0402])). See LICENSE.txt for further details.
