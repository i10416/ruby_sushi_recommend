class Array
	#calculate correlation_coefficient
	def r(y)
		raise "Argument is not a Array class!"  unless y.class == Array
	    raise "Self array is nil!"              if self.size == 0
		raise "Argument array size is invalid!" unless self.size == y.size
		
		mean_x = self.inject(0) { |s, a| s += a } / self.size.to_f
	    mean_y = y.inject(0) { |s, a| s += a } / y.size.to_f
	    cov = self.zip(y).inject(0) { |s, a| s += (a[0] - mean_x) * (a[1] - mean_y) }
	    var_x = self.inject(0) { |s, a| s += (a - mean_x) ** 2 }
		var_y = y.inject(0) { |s, a| s += (a - mean_y) ** 2 }
		raise "Can not Divide by Zero" if var_x * var_y == 0
		r = cov / Math.sqrt(var_x)
		r /= Math.sqrt(var_y)
	end

	def mean
		self.sum/self.length.to_f
	end
	
	def nth_dev(n)
		self[n] - self.mean()
	end
end
