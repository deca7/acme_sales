# frozen_string_literal: true

require_relative 'entities/product'
require_relative 'entities/basket'
require_relative 'strategies/delivery_strategy'
require_relative 'strategies/offer_strategy'
require_relative 'services/catalogue_service'

# Main module for the library
module AcmeSales
  # Convenience methods
  def self.create_basket
    Services::CatalogueService.create_basket
  end

  def self.products
    Services::CatalogueService.products
  end

  def self.version
    '1.0.0'
  end
end
