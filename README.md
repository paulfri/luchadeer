# Luchadeer

[![Build Status](https://travis-ci.org/paulfri/luchadeer.png?branch=master)][build]
[![Coverage Status](https://coveralls.io/repos/paulfri/luchadeer/badge.png?branch=master)][coverage]
[![Code Climate](https://codeclimate.com/github/paulfri/luchadeer.png)][grade]

[build]: https://travis-ci.org/paulfri/luchadeer
[coverage]: https://coveralls.io/r/paulfri/luchadeer?branch=master
[grade]: https://codeclimate.com/github/paulfri/luchadeer

The bombingest Giant Bomb API client library for Ruby.

## Features
1. Fully unit-tested.
2. Caches API responses.
3. fully.recursive.dot.syntax, no random hash[:syntax] cutoff point
4. Fetch full details for partial objects (e.g. embedded results) with object.detail.
5. Thread-ready (thready?): no global or class state. Use convenience methods to use a default client per-thread, or use an alternate syntax for full control.

## Configuration
Get your API key [here](http://www.giantbomb.com/api). If you have a premium account, your API key should give you access to subscriber-only video resources, as well as links to HD-quality videos.

```ruby
Luchadeer.configure(api_key: 'my_api_key') # default client for this thread
Luchadeer::Client.new(api_key: 'my_api_key')

# You can also pass a block to either method, and it will yield the client object to configure to your liking.
Luchadeer.configure do |client|
  client.api_key = 'my_api_key'
end
```

## Supported resources
* game
* franchise
* character
* concept
* object
* location
* person
* company
* video

## Usage

```ruby
# Resources
Luchadeer::Game.find(21373) # or...
my_client.game(21373) # => #<Luchadeer::Game name="Shin Megami Tensei: Persona 4" ...>

# Search: mix and match whatever syntax you like
Luchadeer::Search.new(page: 1, limit: 50, query: 'valkyria').fetch
Luchadeer::Search.new.page(1).limit(50).query('valkyria').fetch
Luchadeer::Search.new { |s|
  s.query = 'valkyria'
  s.page = 1
  s.limit = 50
}.fetch
```

## TODO
1. Add custom filtering to search (i.e., the 'filter' request parameter).
2. Add per-resource searching class methods on each resource object.
3. Refactor the test suite with shared example groups.
4. Make the caching layer more flexible - more options besides in-memory store. Add a null store, too.
