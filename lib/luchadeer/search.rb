require 'luchadeer/character'
require 'luchadeer/game'
require 'luchadeer/franchise'

module Luchadeer
  class Search
    attr_accessor :query

    RESOURCE_TYPES = {
      'game'      => Luchadeer::Game,
      'franchise' => Luchadeer::Franchise,
      'character' => Luchadeer::Character
    }

    def initialize(query)
      @query = query
    end

    def fetch
      Luchadeer.client.get('search', search_params).body[:results].map do |r|
        type = r.delete(:resource_type)
        RESOURCE_TYPES[type] && RESOURCE_TYPES[type].new(r)
      end.compact
    end

  private

    def search_params
      { query: @query }
    end

  end
end
