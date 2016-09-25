# Friendly Routes
Friendly Routes creates DSL for creating rails routes with human friendly URLs

[![Code Climate](https://codeclimate.com/github/RoM4iK/friendly_routes/badges/gpa.svg)](https://codeclimate.com/github/RoM4iK/friendly_routes)
[![Build Status](https://travis-ci.org/RoM4iK/friendly_routes.svg?branch=master)](https://travis-ci.org/RoM4iK/friendly_routes)
## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'friendly_routes'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install friendly_routes
```
## Examples
### Routes.rb example

```ruby
# config/routes.rb
free = FriendlyRoutes::Params::BooleanParams.new(:free, true: :free, false: :paid)
category = FriendlyRoutes::Params::CollectionParams.new(:category_id, Category, :title)

dummies_route = FriendlyRoutes::Route.new([free, category], controller: :dummies, action: :index)

friendly_url_for dummies_route, :get # '/:free/:category'

second_dummies_route = FriendlyRoutes::Route.new([free, 'categories', category], controller: :dummies, action: :index)

friendly_url_for dummies_route, :get, '/' # '/:free/categories/:category'
friendly_url_for dummies_route, :get, '/hello/' # '/hello/:free/categories/:category'
```

### Controller example

```ruby
# app/controllers/dummies_controller.rb
class DummiesController < ApplicationController
  before_action :parse_friendly_routes, only: [:index]
  def index
  end
end
```

### Request result example

```
 Categories:
 <Category id: 1, title: "lorem">
 <Category id: 2, title: "ipsum">


GET "/free/lorem" - { free: true, category_id: 1}
GET "/free/ipsum" - { free: true, category_id: 2}
GET "/paid/lorem" - { free: false, category_id: 1}
GET "/paid/ipsum" - { free: false, category_id: 2}
```

## Contributing
Feel free to contribute into this repository by creating pull requests.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
