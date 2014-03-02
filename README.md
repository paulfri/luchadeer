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
```

## Supported resources
All Giant Bomb API resources are supported. For a full list, see the [Giant Bomb API documentation][docs].

[docs]: http://www.giantbomb.com/api/documentation

## Usage

```ruby
# Resources (by name)
Luchadeer::Game.search 'persona 4'
Luchadeer::Location.search 'inaba'
Luchadeer::Video.search 'unprofessional'

# Resources (by id)
Luchadeer::Game.find(21373) # or ...
my_client.game(21373) # => #<Luchadeer::Game name="Shin Megami Tensei: Persona 4" ...>

# Custom searches
Luchadeer::Search.new(page: 1, limit: 50, query: 'valkyria').fetch

search = Luchadeer::Search.new
search.page(1).limit(50).sort('name', :desc) # default is :asc
search.resources [Luchadeer::Game, Luchadeer::Character] # strings work too
search.query 'valkyria'
search.fetch

search = Luchadeer::Search.new do |s|
  s.query = 'valkyria'
  s.page = 1
  s.limit = 50
end

results = search.fetch
```

## TODO
1. Add custom filtering to search (i.e., the 'filter' request parameter).
2. Make the caching layer more flexible - more options besides in-memory store. Add a null store, too.
3. 'ghost' object pattern - lazy-load details for partial models when they're accessed, instead of requiring manual '.detail' invocation
