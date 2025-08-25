# frozen_string_literal: true

require_relative '../entities/product'
require_relative '../entities/basket'
require_relative '../strategies/delivery_strategy'
require_relative '../strategies/offer_strategy'

module Services
  class CatalogueService
    PRODUCTS = [
      Entities::Product.new('R01', 'Red Widget', 32.95),
      Entities::Product.new('G01', 'Green Widget', 24.95),
      Entities::Product.new('B01', 'Blue Widget', 7.95)
    ].freeze

    DELIVERY_TIERS = [
      [0, 4.95],    # Under $50: $4.95
      [50, 2.95],   # $50-$89.99: $2.95
      [90, 0.0]     # $90+: Free delivery
    ].freeze

    def self.products
      PRODUCTS
    end

    # Default delivery strategy
    def self.delivery_strategy
      Strategies::TieredDeliveryStrategy.new(DELIVERY_TIERS)
    end

    # Initial offer
    def self.offers
      [Strategies::BuyOneGetOneHalfPriceOffer.new('R01')]
    end

    def self.create_basket
      Entities::Basket.new(products, delivery_strategy, offers)
    end

    # Different configurations to show extensibility
    def self.create_flat_rate_basket(rate = 5.0)
      delivery = Strategies::FlatRateDeliveryStrategy.new(rate)
      Entities::Basket.new(products, delivery, offers)
    end

    def self.create_free_delivery_basket
      delivery = Strategies::FreeDeliveryStrategy.new
      Entities::Basket.new(products, delivery, offers)
    end

    def self.create_custom_basket(delivery_strategy, offer_strategies = [])
      Entities::Basket.new(products, delivery_strategy, offer_strategies)
    end
  end
end
