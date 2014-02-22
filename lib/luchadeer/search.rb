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

    QUERY_PARAMS = [:query, :limit, :page]
    attr_writer *QUERY_PARAMS

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

    QUERY_PARAMS.each do |method|
      define_method("#{method}") do |param = nil|
        ivar = "@#{method.to_s}"
        return instance_variable_get(ivar) unless param
        instance_variable_set(ivar, param)
        self
      end
    end

  private

    def search_params
      { query: @query, limit: @limit, page: @page }.delete_if { |_, v| v.nil? }
    end

  end
end
