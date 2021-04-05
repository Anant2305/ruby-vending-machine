module Payments

	attr_accessor :value, :amounts

	def initialize_amounts	
        @amounts = {  "£2" 	=> 0,
		            "£1" 	=> 0,
                    "50p"   => 0,
					"20p"   => 0,
					"10p"   => 0,
					"5p" 	=> 0,
					"2p" 	=> 0,
					"1p" 	=> 0
            }
	end

	def add_payments(denomination, quantity)
		 @amounts[denomination] += quantity
	end

	def decimal_value(amount)
		if amount.end_with?("p")
			 (amountn.chop.to_f / 100)
		else
			(amount[1..-1].to_f)
		end
	end

	def value
		value = 0.0
		@amounts.each{|denomination, quantity| value += (decimal_value(denomination) * quantity)}
		return value.round(2)
	end


	def find_change_required(value_paid, product_cost)
		@change_required = (value_paid - product_cost).round(2)
	end

	def change_returned
		@value_of_change = 0.0
		@return_to_customer =[]
		while @change_required != 0.0
			amount = select_amount
            get_change(amount)
			@change_required = (@change_required -= decimal_value(amount)).round(2)
		end
		@return_to_customer
	end

	def select_amount
		@amounts.find{|denomination, quantity| decimal_value(denomination) <= @change_required && quantity > 0}[0]
	end

	def get_change(amount)
		remove_from_stack(amount)
		@return_to_customer << amount
		@value_of_change += decimal_value(amount)
	end

	def remove_from_stack(amount)
		@amounts[amount] -= 1
	end






end