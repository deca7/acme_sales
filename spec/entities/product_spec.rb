# frozen_string_literal: true

RSpec.describe Entities::Product do
  let(:first_product) { described_class.new('R01', 'Red Widget', 32.95) }
  let(:second_product) { described_class.new('R01', 'Red Widget', 32.95) }
  let(:third_product) { described_class.new('G01', 'Green Widget', 24.95) }

  it 'compares products by code' do
    expect(first_product).to eq(second_product)
    expect(first_product).not_to eq(third_product)
  end

  it 'is hashable by code' do
    h = {}
    h[first_product] = 'foo'
    expect(h[second_product]).to eq('foo')
  end

  it 'has a nice string representation' do
    expect(first_product.to_s).to include('Red Widget')
    expect(first_product.to_s).to include('R01')
    expect(first_product.to_s).to include('32.95')
  end
end
