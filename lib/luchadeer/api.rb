require 'luchadeer/api/resources'
require 'luchadeer/api/search'

module Luchadeer
  module API
    API_MODULES = [
      Luchadeer::API::Accessories,
      Luchadeer::API::Characters,
      Luchadeer::API::Companies,
      Luchadeer::API::Concepts,
      Luchadeer::API::Franchises,
      Luchadeer::API::Games,
      Luchadeer::API::Locations,
      Luchadeer::API::Objects,
      Luchadeer::API::People,
      Luchadeer::API::Videos,

      Luchadeer::API::Search
    ]

    API_MODULES.each do |mod|
      include mod
    end

    attr_writer :cache

    def cache(key, refresh = false, &blk)
      @cache ||= {}
      @cache.delete(key) if refresh

      if block_given?
        @cache[key] || (@cache[key] = yield)
      else
        @cache.fetch(key)
      end
    end

    def fetch(path, refresh = false, klass = Luchadeer::Resource)
      return unless results = cache(path, refresh) do
        get(path).body[:results]
      end

      results.is_a?(Array) ? results.map { |r| klass.new(r) } : klass.new(results)
    end

  end
end
