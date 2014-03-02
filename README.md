# Luchadeer

[![Build Status](https://travis-ci.org/paulfri/luchadeer.png?branch=master)][build]
[![Coverage Status](https://coveralls.io/repos/paulfri/luchadeer/badge.png?branch=master)][coverage]
[![Code Climate](https://codeclimate.com/github/paulfri/luchadeer.png)][grade]

[build]: https://travis-ci.org/paulfri/luchadeer
[coverage]: https://coveralls.io/r/paulfri/luchadeer?branch=master
[grade]: https://codeclimate.com/github/paulfri/luchadeer

The bombingest Giant Bomb API client library for Ruby.

## Features
1. Supports all resources exposed by the Giant Bomb API. For a full list, see the [documentation][docs].
2. Caches API responses.
3. Fully unit-tested.
4. fully.recursive.dot.syntax, no random hash[:syntax] cutoff point
5. Fetch full details for partial objects (e.g. embedded results) with object.detail.
6. Use convenience methods on a default client per-thread, or use an alternate syntax for full control of the client object.

[docs]: http://www.giantbomb.com/api/documentation

## Configuration
Get your API key [here](http://www.giantbomb.com/api). If you have a premium account, your API key should give you access to subscriber-only video resources, as well as links to HD-quality videos.

```ruby
Luchadeer.configure(api_key: 'my_api_key') # default client for this thread
Luchadeer::Client.new(api_key: 'my_api_key')
```

## Usage

```ruby
# Resources by name
# (you can omit the search query if you like)
Luchadeer::Game.search 'persona 4'
my_client.games 'persona 4'
Luchadeer::Video.search 'unprofessional'
my_client.videos 'unprofessional'

# Resources by ID
Luchadeer::Game.find 21373
my_client.game 21373
Luchadeer::RatingBoard.find 3
my_client.rating_board 3

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
