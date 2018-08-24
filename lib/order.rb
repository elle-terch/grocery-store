# require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    validate_fulfillment_status
  end


  def validate_fulfillment_status
    fulfillment_status_options = [:pending, :paid, :processing, :shipped, :complete]
    if fulfillment_status_options.include?(fulfillment_status) == false
      raise ArgumentError.new("Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete")
    end
  end


  def total
    total_cost = 0

    @products.each do |product, cost|
      total_cost += cost
    end

    total = total_cost + (total_cost * 0.075)
    return total.round(2)
  end


  def add_product(product_name, price)
    check_product_duplicates(product_name)
    @products[product_name] = price
  end
  

  def check_product_duplicates(product_name)
    @products.each do
      if @products.key?(product_name)
        raise ArgumentError.new("A product with that name already exists.")
      end
    end
  end

end
