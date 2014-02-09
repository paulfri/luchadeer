require 'luchadeer/character'
require 'luchadeer/company'
require 'luchadeer/concept'
require 'luchadeer/franchise'
require 'luchadeer/game'
require 'luchadeer/location'
require 'luchadeer/object'
require 'luchadeer/person'
require 'luchadeer/video'

module Luchadeer
  class Search
    attr_accessor :query

    RESOURCE_TYPES = {
      'character' => Luchadeer::Character,
      'company'   => Luchadeer::Company,
      'concept'   => Luchadeer::Concept,
      'franchise' => Luchadeer::Franchise,
      'game'      => Luchadeer::Game,
      'location'  => Luchadeer::Location,
      'object'    => Luchadeer::Object,
      'person'    => Luchadeer::Person,
      'video'     => Luchadeer::Video
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
