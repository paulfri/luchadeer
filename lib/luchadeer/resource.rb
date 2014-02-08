module Luchadeer
  class Resource < OpenStruct

    # http://andreapavoni.com/blog/2013/4/create-recursive-openstruct-from-a-ruby-hash
    def initialize(hash = nil)
      @table = {}
      @hash_table = {}

      return unless hash

      hash.each do |k, v|
        @hash_table[k.to_sym] = v

        @table[k.to_sym] = case v
        when Hash then Luchadeer::Resource.new(v)
        when Array then v.collect { |n| Luchadeer::Resource.new(n) }
        else v
        end

        new_ostruct_member(k)
      end
    end

    def to_h
      @hash_table
    end

  end
end
