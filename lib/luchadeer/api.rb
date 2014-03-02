require 'luchadeer/api/resources'
require 'luchadeer/api/search'

module Luchadeer
  module API
    include Luchadeer::API::Search

    RESOURCES = [
      Luchadeer::Accessory,
      Luchadeer::Character,
      Luchadeer::Company,
      Luchadeer::Concept,
      Luchadeer::Franchise,
      Luchadeer::Game,
      Luchadeer::Location,
      Luchadeer::Object,
      Luchadeer::Person,
      Luchadeer::Video
    ]

    RESOURCES.each do |klass|
      define_method klass::SINGULAR do |id, refresh = false|
        fetch("#{klass::SINGULAR}/#{klass::RESOURCE_ID}-#{id}", refresh, klass)
      end

      define_method klass::PLURAL do |query = nil, refresh = false|
        search_resource(klass::PLURAL, query, refresh, klass)
      end
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

    def search_resource(endpoint, query, refresh = false, klass = Luchadeer::Resource)
      query_string = "?filter=name:#{query}" unless query.nil? or query.length < 1
      fetch("#{endpoint}#{query_string}", refresh, klass)
    end

  end
end
