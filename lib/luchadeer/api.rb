require 'luchadeer/api/characters'
require 'luchadeer/api/franchises'
require 'luchadeer/api/games'

module Luchadeer
  module API
    API_MODULES = [
      Luchadeer::API::Characters,
      Luchadeer::API::Games,
      Luchadeer::API::Franchises,
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

    def fetch(path, refresh = false)
      cache(path, refresh) do
        get(path).body[:results]
      end
    end

  end
end
