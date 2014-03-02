require 'luchadeer/resources'

module Luchadeer
  module API
    attr_writer :cache

    RESOURCES = [
      Luchadeer::Accessory,
      Luchadeer::Character,
      Luchadeer::Chat,
      Luchadeer::Company,
      Luchadeer::Concept,
      Luchadeer::Franchise,
      Luchadeer::Game,
      Luchadeer::GameRating,
      Luchadeer::Genre,
      Luchadeer::Location,
      Luchadeer::Object,
      Luchadeer::Person,
      Luchadeer::Platform,
      Luchadeer::Promo,
      Luchadeer::RatingBoard,
      Luchadeer::Region,
      Luchadeer::Release,
      Luchadeer::Review,
      Luchadeer::Theme,
      Luchadeer::UserReview,
      Luchadeer::Video,
      Luchadeer::VideoType
    ]

    RESOURCES.each do |resource|
      define_method resource::DETAIL do |id, refresh = false|
        fetch("#{resource::DETAIL}/#{resource::ID}-#{id}", refresh, resource)
      end

      define_method resource::LIST do |query = nil, refresh = false|
        query_string = "?filter=name:#{query}" unless query.nil? or query.length < 1
        fetch("#{resource::LIST}#{query_string}", refresh, resource)
      end
    end

    def cache(key, refresh = false)
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
