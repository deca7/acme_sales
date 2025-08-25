#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/acme_sales'

product_codes = ARGV.map(&:strip).reject(&:empty?)

if product_codes.empty?
  puts 'Enter product codes, separated by commas (e.g., R01,G01):'
  input = $stdin.gets.chomp
  product_codes = input.split(',').map(&:strip)
end

basket = AcmeSales.create_basket

product_codes.each do |code|
  basket.add(code)
rescue ArgumentError => e
  puts "Error: #{e.message}"
  exit 1
end

puts "\n🧾 Basket Breakdown:"
if basket.empty?
  puts '  (Basket is empty.)'
else
  basket.items.each do |product, quantity|
    puts "  #{product.name.ljust(15)} x #{quantity} @ $#{'%.2f' % product.price} = $#{format(
      '%.2f', product.price * quantity
    )}"
  end

  subtotal = basket.subtotal
  discounts = basket.total_discounts
  delivery = basket.delivery_cost
  total = basket.total

  puts "\n  Subtotal:   $#{'%.2f' % subtotal}"
  puts "  Discounts: -$#{'%.2f' % discounts}" if discounts.positive?
  puts "  Delivery:   $#{'%.2f' % delivery}"
  puts '---------------------------'
  puts "  TOTAL:      $#{'%.2f' % total}"
end
