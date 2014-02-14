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
    attr_writer :query, :limit, :page

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

    def initialize(opts = {})
      opts.each do |key, value|
        send(:"#{key}=", value)
      end

      yield self if block_given?
    end

    def fetch
      Luchadeer.client.get('search', search_params).body[:results].map do |r|
        type = r.delete(:resource_type)
        RESOURCE_TYPES[type] && RESOURCE_TYPES[type].new(r)
      end.compact
    end

    def limit(l = nil)
      return @limit unless l
      @limit = l
      self
    end

    def query(q = nil)
      return @query unless q
      @query = q
      self
    end

    def page(p = nil)
      return @page unless p
      @page = p
      self
    end

  private

    def search_params
      { query: @query, limit: @limit, page: @page }.delete_if { |_, v| v.nil? }
    end

  end
end
