class Array
	#calculate correlation_coefficient
	def mean
		self.sum.fdiv(self.length)
	end
	def r(y)
		raise "Argument is not a Array class!"  unless y.class == Array
	    raise "Self array is nil!"              if self.size == 0
		raise "Argument array size is invalid!" unless self.size == y.size
		
		mean_x = self.mean
		mean_y = y.mean

	    cov = self.zip(y).inject(0) { |s, (a,b)| s + (a - mean_x) * (b - mean_y) }
	    var_x = self.inject(0) { |s, a| s + (a - mean_x) ** 2 }
		var_y = y.inject(0) { |s, a| s + (a - mean_y) ** 2 }
		raise "Can not Divide by Zero" if var_x * var_y == 0
		r = cov / Math.sqrt(var_x)
		r /= Math.sqrt(var_y)
	end

	
	def nth_dev(n)
		self[n] - self.mean()
	end
end
