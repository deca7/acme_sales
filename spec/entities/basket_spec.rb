# frozen_string_literal: true

RSpec.describe Entities::Basket do
  let(:red_widget) { Entities::Product.new('R01', 'Red Widget', 32.95) }
  let(:green_widget) { Entities::Product.new('G01', 'Green Widget', 24.95) }
  let(:blue_widget) { Entities::Product.new('B01', 'Blue Widget', 7.95) }

  let(:products) { [red_widget, green_widget, blue_widget] }

  let(:delivery_strategy) do
    Strategies::TieredDeliveryStrategy.new([[0, 4.95], [50, 2.95], [90, 0.0]])
  end

  let(:offers) { [Strategies::BuyOneGetOneHalfPriceOffer.new('R01')] }

  let(:basket) { described_class.new(products, delivery_strategy, offers) }

  describe '#add' do
    it 'adds products to basket' do
      expect { basket.add('R01') }.to change { basket.items.values.sum }.by(1)
    end

    it 'adds more than one of the same product' do
      basket.add('R01')
      basket.add('R01')
      expect(basket.items.values_at(Entities::Product.new('R01', 'Red Widget',
                                                          32.95))).to eq([2])
    end

    it 'raises error for unknown product code' do
      expect do
        basket.add('XXX')
      end.to raise_error(ArgumentError, 'Product XXX not found')
    end
  end

  describe '#subtotal' do
    it 'returns 0 for empty basket' do
      expect(basket.subtotal).to eq(0)
    end

    it 'returns correct subtotal for products' do
      basket.add('R01')
      basket.add('B01')
      expect(basket.subtotal).to eq(32.95 + 7.95)
    end
  end

  describe '#total' do
    context 'when official test cases are run' do
      it('B01, G01') do
        b = Services::CatalogueService.create_basket
        b.add('B01')
        b.add('G01')
        expect(b.total).to eq(37.85)
      end

      it('R01, R01') do
        b = Services::CatalogueService.create_basket
        2.times { b.add('R01') }
        expect(b.total).to eq(54.37)
      end

      it('R01, G01') do
        b = Services::CatalogueService.create_basket
        b.add('R01')
        b.add('G01')
        expect(b.total).to eq(60.85)
      end

      it('B01, B01, R01, R01, R01') do
        b = Services::CatalogueService.create_basket
        %w[B01 B01 R01 R01 R01].each { |code| b.add(code) }
        expect(b.total).to eq(98.27)
      end
    end
  end

  describe '#empty?' do
    it 'returns true for new basket' do
      expect(basket).to be_empty
    end

    it 'returns false after adding an item' do
      basket.add('B01')
      expect(basket).not_to be_empty
    end
  end
end
