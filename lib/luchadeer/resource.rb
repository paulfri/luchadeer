module Luchadeer
  class Resource < OpenStruct

    # http://andreapavoni.com/blog/2013/4/create-recursive-openstruct-from-a-ruby-hash
    def initialize(hash = nil)
      @table = {}
      @hash_table = {}

      return unless hash

      hash.each do |k, v|
        @table[k.to_sym] = (v.is_a?(Hash) ? Luchadeer::Resource.new(v) : v)
        @hash_table[k.to_sym] = v

        new_ostruct_member(k)
      end
    end

    def to_h
      @hash_table
    end
  end
end
