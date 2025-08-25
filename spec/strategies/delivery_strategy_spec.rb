# frozen_string_literal: true

RSpec.describe Strategies::TieredDeliveryStrategy do
  let(:strategy) { described_class.new([[0, 4.95], [50, 2.95], [90, 0.0]]) }

  it 'applies correct delivery tiers' do
    expect(strategy.cost_for(0)).to eq(4.95)
    expect(strategy.cost_for(49.99)).to eq(4.95)
    expect(strategy.cost_for(50.00)).to eq(2.95)
    expect(strategy.cost_for(70.00)).to eq(2.95)
    expect(strategy.cost_for(89.99)).to eq(2.95)
    expect(strategy.cost_for(90.00)).to eq(0.0)
    expect(strategy.cost_for(150.00)).to eq(0.0)
  end
end

RSpec.describe Strategies::FlatRateDeliveryStrategy do
  let(:flat) { described_class.new(5.0) }

  it 'always applies the flat rate' do
    1.upto(200) do |total|
      expect(flat.cost_for(total)).to eq(5.0)
    end
  end
end

RSpec.describe Strategies::FreeDeliveryStrategy do
  let(:free) { described_class.new }

  it 'always returns zero' do
    1.upto(200) do |total|
      expect(free.cost_for(total)).to eq(0.0)
    end
  end
end
