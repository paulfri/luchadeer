require 'luchadeer/resources'

module Luchadeer
  module API
    attr_writer :cache

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

    RESOURCES.each do |resource|
      define_method resource::SINGULAR do |id, refresh = false|
        fetch("#{resource::SINGULAR}/#{resource::RESOURCE_ID}-#{id}", refresh, resource)
      end

      define_method resource::PLURAL do |query = nil, refresh = false|
        search_resource(resource::PLURAL, query, refresh, resource)
      end
    end

    def search(*args, &blk)
      Luchadeer::Search.new(*args, &blk).fetch
    end

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
