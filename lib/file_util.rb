def get_preferences_data_from(path)
	preferences=[]
	File.open(path) do |f|
		f.each_line do |line|
			preferences << line.chomp.split(" ").map(&:to_f)
		end
	end
	preferences
end

def get_sushi_hash_from(path)
	sushi_hash={}
	File.open(path) do |f|
		f.each_line do |line|
			matched = line.match(/(\d+):(\w+)/)
			sushi_hash[matched[2]] = matched[1].to_i
		end
	end
	sushi_hash
end
