require 'ostruct'

module Luchadeer
  class Resource < ::OpenStruct

    class << self
      def find(id, refresh = false)
        Luchadeer.client.send(self::DETAIL, id, refresh)
      end

      def search(query = nil, refresh = false)
        Luchadeer.client.send(self::LIST, query, refresh)
      end
    end

    # http://andreapavoni.com/blog/2013/4/create-recursive-openstruct-from-a-ruby-hash
    def initialize(hash = nil)
      @table = {}
      @hash_table = {}

      return unless hash

      hash.each do |k, v|
        @hash_table[k.to_sym] = v
        @table[k.to_sym] = deep_structify(k, v)
        new_ostruct_member(k)
      end
    end

    def to_h
      @hash_table
    end

    def detail
      api_detail_url ? Luchadeer.client.fetch(api_detail_url, false, self.class) : self
    end

  private

    def deep_structify(k, v)
      case v
      when Hash  then Luchadeer::Resource.new(v)
      when Array then v.map { |n| Luchadeer::Resource.new(n) }
      else v
      end
    end

  end
end
