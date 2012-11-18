# Sprockets MongoDB Cache

A cache store for Sprockets which utilities MongoDB.


## Usage

Gemfile:

```ruby
gem "sprockets"
gem "sprockets-cache-mongodb"
# ...
```

config.ru:

```ruby
require "sprockets-cache-mongodb"
env = Sprockets::Environment.new
env.cache = Sprockets::Cache::MongoDBStore.new(mongo, "sprockets")
# ...
```

Where the first argument is a Mongo connection (mongo-ruby-driver by 10gen), and the other (which is optional) is a database name.
