odds = [1,3,5,7,9]

=begin
# Add your code below !
odds.each do |item|
	item *= 2
	print "#{item}"
end
=end

# Another way to express 
odds.each {
	|item|
	item *= 2
	print "#{item}"
}
