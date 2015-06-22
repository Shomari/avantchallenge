require 'pry'
class ComputeFactor

	attr_accessor :array, :output

	@@normal_instances = {}
	@@reverse_instances = {}

	def initialize(array)
		@array = array.sort
		@output = {}		
	end

	def normal_factor
		if @@normal_instances.include? @array
			@@normal_instances[@array]
		else
			factor
		end
	end

	def reverse_factor
		if @@reverse_instances.include? @array
			@@reverse_instances[@array]
		else
			reverse
		end
	end


	private

	def reverse
	output = {}
	@array.each do |number|
		factors = []
		@array.each do |num|
			if num % number == 0	
				factors << num
			end	
		end	
		factors = factors - [number]
		output[number] = factors	
	end
	reverse_save(output)
	@output = output

	end

	def factor
		p "in factor"
		output = {}
		@array.each do |number|
			factors = []
			@array.each do |num|
				if number % num == 0	
					factors << num
				end	
			end	
			factors = factors - [number]
			output[number] = factors	
		end
		normal_save(output)
		@output = output
	end

	def normal_save(output)
		@@normal_instances[@array] = output
	end

	def reverse_save(output)
		@@reverse_instances[@array] = output
	end
end

# Additional Question answers

# 1. I implemented a cache system by making each calculation an 
# 	 instance of the ComputeFactor class.  By putting the array
# 	 and the output inside an class variable array,  I can check the 
# 	 array first before doing any calculation to see if the instance 
#  	 exsists.

# 2. The cache system simply iterates through each instance of the ComputerFactor
# 	  to see if their are any matches.  I used ruby's include method to do this.  
#    possibly building my own matching algorithim could make it a bit more performant

# 3.  See reverse method above.  Reversing does not change the caching algorithim.

array1 = ComputeFactor.new([10, 5, 2, 20])
array2 = ComputeFactor.new([1,2,4])
cached_array = ComputeFactor.new([10, 5, 2, 20])

p array1.normal_factor
p array2.normal_factor
p cached_arry.normal_factor # If ran in terminal, you will notice that the string
													  # in factor only appears 2 times, even though I am performing
													  # three intances.  It is becuase the third call is cached
													  # and no math is taking place.

p array1.reverse_factor  		# Last output is a reverse factor


