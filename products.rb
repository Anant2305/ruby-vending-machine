module Products

	attr_accessor :products, :selection

	def initialize_product_stack
		@products_stock = [ 
				        ["pepsi", 	    1.00,	0],
						["pepsi_max",	1.25,	0],
						["coke",		1.00,	0],
						["diet_coke",	1.25,	0],
						["coke_zero",	1.30,	0],
						["orange_juice",2.00,   0],
						["water",	    2.25,	0]
												]
	end

	def choose(product)
		@selection = product
		raise "This product is not in stock" unless @products_stock[find(product)][2] > 0
		@products_stock[find(product)][2] -=1
		return @products_stock[find(product)][0]
	end

	def restock(product, quantity)
	@products_stock[find(product)][2] += quantity
	end

	def find(product)
		@products_stock.find_index{|item|item[0] == product}
	endß
end