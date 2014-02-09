require 'luchadeer/api/games'
require 'luchadeer/api/franchises'

module Luchadeer
  module API
    API_MODULES = [
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

  end
end
