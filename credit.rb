require 'date'

class Credit
	attr_accessor :apr, :limit, :balance, :ledger

	def initialize(apr, limit)
		@apr = apr
		@limit = limit
		@balance =  0
		@ledger = {}
		@intrest = []
	end

	def draw(amount)
		calculate_interest(days_since_transaction)
		@balance = @balance + amount
		@ledger[DateTime.now] = @balance
	end

	def payment(amount)
		calculate_interest(days_since_transaction)		
		@balance = @balance - amount
		@ledger[DateTime.now] = @balance
	end

	# Need this to calculate the interest owed for each time period
	def days_since_transaction
		last_date = @ledger.keys.last
		days = Time.now - last_date
	end

	# Everytime there is a trancastion, calculate intrest owed since
	# last transaction and add it to interest array
	def calculate_interest(days_since_transaction)
		@interest << @balance * @apr / 365 * days_since_transaction
	end

	# Would have a cron job run this at the end of each month
	# Calculate's total interest for the bill
	def end_of_month_bill
		@balance + @interest.reduce(:+)
	end
end