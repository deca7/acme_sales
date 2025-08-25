# frozen_string_literal: true

RSpec.describe Strategies::BuyOneGetOneHalfPriceOffer do
  let(:prod) { Entities::Product.new('R01', 'Red Widget', 32.95) }
  let(:offer) { described_class.new('R01') }

  it 'returns 0 for no matching items' do
    expect(offer.discount_for({})).to eq(0.0)
  end

  it 'returns 0 for only one item' do
    expect(offer.discount_for({ prod => 1 })).to eq(0.0)
  end

  it 'applies half price discount for pairs' do
    expect(offer.discount_for({ prod => 2 })).to eq((32.95 * 0.5).round(2))
  end

  it 'applies half price per complete pair only' do
    expect(offer.discount_for({ prod => 3 })).to eq((32.95 * 0.5).round(2))
    expect(offer.discount_for({ prod => 4 })).to eq((32.95 * 0.5 * 2).round(2))
  end
end

RSpec.describe Strategies::PercentageDiscountOffer do
  let(:prod) { Entities::Product.new('G01', 'Green Widget', 24.95) }
  let(:offer) { described_class.new('G01', 0.1) }

  it 'returns 0 for no matching items' do
    expect(offer.discount_for({})).to eq(0.0)
  end

  it 'applies percentage discount per quantity' do
    expect(offer.discount_for({ prod => 2 })).to eq((24.95 * 2 * 0.1).round(2))
  end
end
