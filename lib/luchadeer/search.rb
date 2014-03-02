require 'luchadeer/api/resources'

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

    QUERY_PARAMS = [:query, :limit, :page, :fields, :resources, :sort]
    attr_writer *QUERY_PARAMS

    QUERY_PARAMS.each do |method|
      define_method("#{method}") do |param = nil|
        ivar = "@#{method.to_s}"
        return instance_variable_get(ivar) unless param
        instance_variable_set(ivar, param)
        self
      end
    end

    def resources(resources = nil)
      return @resources unless resources
      append_resources(resources)
      self
    end

    def sort(attribute = nil, dir = :asc)
      return @sort unless attribute
      @sort = "#{attribute}:#{dir}"
      self
    end

  private

    def search_params
      { query: @query, limit: @limit, resources: @resources, page: @page,
        sort: @sort }.delete_if { |_, v| v.nil? }
    end

    def append_resources(resources)
      @resources ||= ''
      resources = (RESOURCE_TYPES.invert[resources] || '') if resources.is_a? Class

      rx = resources.is_a?(Array) ? resources : resources.split(',')
      rx.each do |r|
        r = (RESOURCE_TYPES.invert[r] || '') if r.is_a? Class        
        RESOURCE_TYPES[r] or raise(ArgumentError, 'Invalid resource type supplied')
        @resources << ",#{r}"
      end

      @resources.sub!(/\A,+/, '')
    end

  end
end
