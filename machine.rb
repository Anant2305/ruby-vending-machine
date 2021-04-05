require_relative 'products'
require_relative 'payments'

class Machine

	attr_reader :user_selection, :user_payment, :user_selection

	include ProductStack
	include CoinStack
		
		def initialize
			self.initialize_products_stock
			self.initialize_amounts
			@user_payment = []
			@user_selection = ""
		end

		def take_stock
			@products_stock.each do |product|
				load_product(product)
			end
		end

		def load_product(product)
				puts "Enter a quantity of #{product[0]} to load"
				quantity = gets.chomp.to_i
				restock(product[0], quantity)
		end

		def take_amount
			@amounts.each do |coin|
				load_coin(amount)
			end
		end

		def select_product
			puts "Please type in the name of your selection"
			@products_stock.each{|product| puts "#{product[0]} : £#{product[1]}" }
			@user_selection = gets.chomp
		end

		def load_amount(amount)
			puts "Enter a quantity of #{amount[0]} to load"
			quantity = gets.chomp.to_i
			add_amount(amount[0], quantity)
		end

		def get_user_payment
			ask_for_amounts
			add_amounts_to_user_payment
			remove_empty_payment_values
		end

		def ask_for_amounts
			puts "Enter a coin and press enter. When finished, hit enter twice"
		end

		def add_amounts_to_user_payment
			inserted_amount = gets.chomp
			while !inserted_amount.empty? do
					@user_payment << inserted_amount
					inserted_amount = gets.chomp
			end
		end

		def validate
			return choose(@user_selection) if payment_sufficient?
			get_user_payment
		end

		def payment_sufficient?
			payment_value >= @stocked_products[find(@user_selection)][1]
		end

		def payment_value
			@user_payment.inject(0){|payment_value, amount| p payment_value += decimal_value(amount)}
		end

		def remove_empty_payment_values
			@user_payment.reject! { |amount| amount.empty? }
		end

		#program sequence methods

		def run
			initial_setup
			vend_products
		end

		def initial_setup
			take_stock
			take_amounts
		end

		def vend_products
			take_user_inputs
			return_product
			return_change
		end

		def take_user_inputs
			select_product
			get_user_payment
			validate
		end

		def return_product
			p "Here is your #{@user_selection}:"
			p choose(@user_selection)
		end

		def return_change
			p "Here is your #{find_change_required(find_payment_value, @products_stock[find(@user_selection)][1])} change"
			p amounts_returned
		end

end






