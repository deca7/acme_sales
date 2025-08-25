# frozen_string_literal: true

module Entities
  class Product
    attr_reader :code, :name, :price

    def initialize(code, name, price)
      @code = code
      @name = name
      @price = price.to_f
    end

    # NOTE: Overriden both == and eql? method for proper matching of the hash
    def ==(other)
      other.is_a?(Product) && code == other.code
    end

    def eql?(other)
      self == other
    end

    def hash
      code.hash
    end

    def to_s
      "#{name} (#{code}): $#{price}"
    end
  end
end
