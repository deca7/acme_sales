# frozen_string_literal: true

module Strategies
  class OfferStrategy
    def discount_for(items)
      raise NotImplementedError, 'Subclasses must implement discount_for method'
    end
  end

  class BuyOneGetOneHalfPriceOffer < OfferStrategy
    def initialize(product_code)
      @product_code = product_code
    end

    def discount_for(items)
      matching_items = items.select do |product, _qty|
        product.code == @product_code
      end
      return 0.0 if matching_items.empty?

      product, quantity = matching_items.first
      pairs = quantity / 2
      (pairs * product.price * 0.5).round(2)
    end
  end

  class PercentageDiscountOffer < OfferStrategy
    def initialize(product_code, percentage)
      @product_code = product_code
      @percentage = percentage
    end

    def discount_for(items)
      matching_items = items.select do |product, _qty|
        product.code == @product_code
      end
      return 0.0 if matching_items.empty?

      product, quantity = matching_items.first
      (product.price * quantity * @percentage).round(2)
    end
  end

  class BuyXGetYFreeOffer < OfferStrategy
    def initialize(product_code, buy_quantity, free_quantity)
      @product_code = product_code
      @buy_quantity = buy_quantity
      @free_quantity = free_quantity
    end

    def discount_for(items)
      matching_items = items.select do |product, _qty|
        product.code == @product_code
      end
      return 0.0 if matching_items.empty?

      product, quantity = matching_items.first
      return 0.0 if quantity < @buy_quantity

      free_items = (quantity / @buy_quantity) * @free_quantity
      (free_items * product.price).round(2)
    end
  end
end
