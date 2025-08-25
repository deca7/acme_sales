# frozen_string_literal: true

RSpec.describe Services::CatalogueService do
  describe '.products' do
    it 'returns the correct list of products' do
      products = described_class.products
      expect(products.map(&:code)).to contain_exactly('R01', 'G01', 'B01')
      expect(products.find { |p| p.code == 'R01' }.price).to eq(32.95)
      expect(products.find { |p| p.code == 'G01' }.name).to eq('Green Widget')
    end
  end

  describe '.delivery_strategy' do
    it 'returns a tiered delivery strategy with correct tiers' do
      strategy = described_class.delivery_strategy
      expect(strategy).to be_a(Strategies::TieredDeliveryStrategy)
      # Spot-check tiers
      expect(strategy.cost_for(30)).to eq(4.95)
      expect(strategy.cost_for(50)).to eq(2.95)
      expect(strategy.cost_for(120)).to eq(0.0)
    end
  end

  describe '.offers' do
    it 'includes the correct offer strategy for red widget' do
      offers = described_class.offers
      expect(offers.map(&:class)).to include(Strategies::BuyOneGetOneHalfPriceOffer)

      offer = offers.find { |o| o.is_a?(Strategies::BuyOneGetOneHalfPriceOffer) }
      expect(offer.instance_variable_get(:@product_code)).to eq('R01')
    end
  end

  describe '.create_basket' do
    it 'returns a basket wired with the correct products, delivery, and offer' do
      basket = described_class.create_basket
      expect(basket).to be_a(Entities::Basket)
      expect(basket.subtotal).to eq(0)
      expect { basket.add('G01') }.to change { basket.subtotal }.by(24.95)
      expect(basket.total).to be > 0
    end
  end

  describe '.create_flat_rate_basket' do
    it 'returns a basket with a flat delivery strategy' do
      basket = described_class.create_flat_rate_basket(5.0)
      expect(basket).to be_a(Entities::Basket)
      # NOTE: G01 ($24.95) subtotal plus flat delivery
      basket.add('G01')
      expect(basket.total).to eq(24.95 + 5.0)
    end
  end

  describe '.create_free_delivery_basket' do
    it 'returns a basket with free delivery' do
      basket = described_class.create_free_delivery_basket
      basket.add('B01')
      expect(basket.total).to eq(7.95)
    end
  end
end
