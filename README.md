# Acme Widget Co - Sales System

A Ruby-based proof of concept for Acme Widget Co's new sales system, implementing basket management with products, delivery costs, and special offers.

## Overview

This system manages a shopping basket for three widget products with dynamic delivery pricing and promotional offers,

## Business Assumptions

1. **Offer Logic**: "Buy one red widget, get second half price" applies to every pair of red widgets
2. **Delivery Calculation**: Based on subtotal after discounts are applied
3. **Price Precision**: All calculations rounded to 2 decimal places
4. **Product Codes**: Case-sensitive input, normalized internally
5. **Error Handling**: Invalid product codes raise descriptive errors

### Products

- **Red Widget (R01)**: $32.95
- **Green Widget (G01)**: $24.95
- **Blue Widget (B01)**: $7.95

### Business Rules

**Delivery Costs:**

- Orders under $50: $4.95 delivery
- Orders $50-$89.99: $2.95 delivery
- Orders $90+: Free delivery

**Special Offers:**

- **Red Widget BOGO**: Buy one red widget, get the second half price

## Quick Start

### Install dependencies

```ruby
bundle install
```

### Show help

```ruby
bundle exec rake help
```

### Run all tests

```ruby
rake spec
```

### Run official test cases

```ruby
rake demo
```

### Run via terminal

```ruby
ruby main.rb R01 R01
ruby main.rb B01 G01
```

**Example Output**

```shell

$ ruy main.rb R01 R01 G01
> 🧾 Basket Breakdown:
  Red Widget      x 2 @ $32.95 = $65.90
  Green Widget    x 1 @ $24.95 = $24.95

  Subtotal:   $90.85
  Discounts: -$16.48
  Delivery:   $2.95
---------------------------
  TOTAL:      $77.32
```

## Architecture

Separation of concerns, what each classes mean

```shell
lib/
├── entities/ # Core business objects
│ ├── product.rb # Widget products entity
│ └── basket.rb # Shopping cart
├── services/ # Application logic
│ └── catalogue_service.rb # Initialization of entities and default data
├── strategies/ # Strategies for flexible usiness rules
│ ├── delivery_strategy.rb # Delivery pricing logic
│ └── offer_strategy.rb # Promotional discounts
└── acme_sales.rb # Main library loader
```

## Others

- Some rubocop violations weren't addressed anymore as they are mostly warnings or live within demo code or CLI code
