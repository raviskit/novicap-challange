require 'json'

class Checkout
  attr_accessor :discounts, :products, :cart, :total_price, :input_items

  # initializing the Checkout class
  def initialize(pricing_rules)
    @discounts = pricing_rules
    @products = initialize_products
    @cart = {}
    @total_price = 0
    @input_items = []
  end

  # Scan an item will add them in the cart and will be considered while calculating total amount.
  def scan(item)
    raise InvalidItemError unless products_hash.keys.include?(item)
    if @cart.key?(item)
      @cart[item] += 1
    else
      @cart[item] = 1
    end
    @input_items << item
    p "Added product #{item}"
  end

  # Returns the toal amount of item added in the cart after applying the discount.
  # If there are no items, It will return 0.
  # else it will check for presence of VOUCHER and TSHIRT items in the cart.
  # if More than 2 vouchers are added, two_for_one discount will applied.
  # if More than 3 tshirts are added, bulk_discount will be applied.
  # else final price will be returned.
  def total
    return p "Total: #{@total_price}€" if @cart.empty?

    p "Items: #{@input_items.each{|item| item }.join(", ")}"

    @cart.each do |item, count|
      price_of_item = products_hash[item]
      if item == "VOUCHER" && count > 1
        price = two_for_one(count, price_of_item)
      elsif item == "TSHIRT" && count >= 3
        price = bulk_discount(count, price_of_item)
      else
        price = price_of_item * count
      end
      @total_price = @total_price + price
    end
    p "Total: #{@total_price}€"
  end

  private

    def initialize_discounts(pricing_rules)
      pricing_rules.map { |discount| Discount.new(discount.transform_keys(&:to_sym)) }
    end

    def initialize_products
      file = File.read('products.json')
      products = JSON.parse(file)
      products.map { |product| Product.new(product.transform_keys(&:to_sym)) }
    end

    # building a product hash with key as product code and value as product price
    def products_hash
      return {} if @products.nil?
      products_hash = {}
      @products.map { |p| products_hash[p.code] = p.price }
      products_hash
    end

    # Discount When more than 2 VOUCHERs are added to the cart.
    def two_for_one(count, price)
      if count.even?
        return (count / 2) * price
      else
        return ((count / 2) + 1) * price
      end
    end

    # Discount When more than 3 TSHIRTs are added to the cart.
    def bulk_discount(count, price)
      return price = (price - 1) * count
    end
end
