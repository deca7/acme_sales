#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/acme_sales'

class Demo
  TEST_CASES = [
    { products: %w[B01 G01], expected: 37.85 },
    { products: %w[R01 R01], expected: 54.37 },
    { products: %w[R01 G01], expected: 60.85 },
    { products: %w[B01 B01 R01 R01 R01], expected: 98.27 }
  ].freeze

  def self.run
    puts '🧪 Official Test Cases for Acme Widget Co'
    puts '=' * 45

    TEST_CASES.each_with_index do |tc, i|
      basket = AcmeSales.create_basket
      tc[:products].each { |code| basket.add(code) }
      actual = basket.total
      exp = tc[:expected]
      status = actual == exp ? '✅ PASS' : '❌ FAIL'
      puts "Test #{i+1}: #{tc[:products].join(', ')} = $#{'%.2f' % actual} (expected $#{'%.2f' % exp}) #{status}"
    end
  end
end

Demo.run if __FILE__ == $PROGRAM_NAME