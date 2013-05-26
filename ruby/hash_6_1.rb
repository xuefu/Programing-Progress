symbol_hash = {
	:xuefu => 3,
	:xuefu_sh => 4,
	:xuefu => 7
}

symbol_hash[:xuefu] = 5

symbol_hash.each do |key,value|
	puts key, value
end
