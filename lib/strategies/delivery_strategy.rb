# frozen_string_literal: true

module Strategies
  class DeliveryStrategy
    def cost_for(subtotal)
      raise NotImplementedError, 'Subclasses must implement cost_for method'
    end
  end

  class TieredDeliveryStrategy < DeliveryStrategy
    def initialize(tiers)
      @tiers = tiers.sort_by { |threshold, _cost| -threshold }
    end

    def cost_for(subtotal)
      _threshold, cost = @tiers.find do |threshold, _cost|
        subtotal >= threshold
      end
      cost || 0
    end
  end

  class FlatRateDeliveryStrategy < DeliveryStrategy
    def initialize(rate)
      @rate = rate
    end

    def cost_for(_subtotal)
      @rate
    end
  end

  class FreeDeliveryStrategy < DeliveryStrategy
    def cost_for(_subtotal)
      0.0
    end
  end
end
