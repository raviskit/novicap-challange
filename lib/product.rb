class Product
  attr_accessor :code, :name, :price, :discount

  def initialize(product)
    @code = product[:code]
    @name = product[:name]
    @price = product[:price]
    @discount_type = product[:discount_type]
  end

end
