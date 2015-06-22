require 'date'
require 'pry'

class Credit
	attr_accessor :apr, :limit, :balance, :ledger

	def initialize(apr, limit)
		@apr = apr
		@limit = limit
		@balance =  0
		@ledger = {}
		@interest = []
	end

	def draw(amount)
		calculate_interest(days_since_transaction)
		@balance = @balance + amount
		@ledger[Date.today] = @balance
	end

	def payment(amount)
		calculate_interest(days_since_transaction)		
		@balance = @balance - amount
		@ledger[Date.today] = @balance
	end

	# Need this to calculate the interest owed for each time period
	def days_since_transaction
		if @ledger.empty?
			return 1
		else
			last_date = @ledger.keys.last 
		end
		days = Date.today - last_date		
	end

	# Everytime there is a trancastion, calculate intrest owed since
	# last transaction and add it to interest array
	def calculate_interest(days_since_transaction)
		@interest << @balance * @apr / 365 * days_since_transaction
	end

	# Would have a cron job run this at the end of each month
	# Calculate's total interest for the bill
	def end_of_month_bill
		calculate_interest(30)  ### 30 should be replaced by days since last transaction
		@balance + @interest.reduce(:+)
	end
end

sho = Credit.new(0.35, 1000)
p sho.draw(300)
p sho.end_of_month_bill