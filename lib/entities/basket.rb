# frozen_string_literal: true

module Entities
  class Basket
    def initialize(catalogue, delivery_strategy, offers = [])
      @catalogue = catalogue
      @delivery_strategy = delivery_strategy
      @offers = offers
      @items = Hash.new(0)
    end

    def add(product_code)
      product = find_product(product_code)
      raise ArgumentError, "Product #{product_code} not found" unless product

      @items[product] += 1
    end

    def total
      (subtotal - total_discounts + delivery_cost).round(2)
    end

    def subtotal
      @items.sum { |product, quantity| product.price * quantity }
    end

    def total_discounts
      @offers.sum { |offer| offer.discount_for(@items) }
    end

    def delivery_cost
      @delivery_strategy.cost_for(subtotal - total_discounts)
    end

    def items
      @items.dup.freeze
    end

    def empty?
      @items.empty?
    end

    private

    def find_product(code)
      @catalogue.find { |product| product.code == code }
    end
  end
end
