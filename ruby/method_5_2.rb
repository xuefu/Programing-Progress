books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]

# To sort our books in ascending order, in-place
books.sort! { |firstBook, secondBook| firstBook <=> secondBook }

# Sort your books in descending order, in-place below

books.sort! { |firstBook, secondBook| secondBook <=> firstBook }

# To sort books in ascending, in-place, which don't use the combined comparison operator
books.sort! do |m, n|
  if m > n
  -1
  elsif m < n
  1
  else
  0
  end
end
