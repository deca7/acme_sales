# frozen_string_literal: true

require 'rspec/core/rake_task'
require_relative 'lib/acme_sales'

desc 'Show usage and capabilities'
task :help do
  puts <<~HELP
    🛒 Acme Widget Co - Sales System

    HOW TO USE:

      ruby main.rb <product_code1> <product_code2> ... <product_codeN>

        - Calculates total for the given list of product codes.
        - Product codes are case-insensitive.
        - If no codes are provided, you'll be prompted for input.

    EXAMPLES:

      ruby main.rb R01 G01           # Red + Green Widget
      ruby main.rb B01 B01 R01       # Two Blue, one Red
      ruby main.rb R01 R01           # Two Red Widgets (offer applies)
      ruby main.rb                   # Will prompt: Enter product codes...

    AVAILABLE PRODUCTS:
    #{AcmeSales.products.map { |p| "    #{p.code}\t- #{p.name}\t($#{p.price})" }.join("\n")}

    TIPS:
    - Separate each product code with a space.
    - Use tab-completion to reduce errors.

    MORE:
      - To run official demo cases:    bundle exec rake demo
      - To run the test suite:         bundle exec rake spec

    For details, see README.md
  HELP
end

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = '--format doc'
end

desc 'Show official demo test cases'
task :demo do
  ruby 'demo.rb'
end

task default: :help
