odds_n_ends = [:weezard, 42, "Trady Blix", 3, true, 19, 12.345]

=begin
ints = odds_n_ends.select do |item|
  item if item.is_a? Integer
  end
=end

ints = odds_n_ends.select { |n| n if n.is_a? Integer }

ints.each { |n| puts n }
