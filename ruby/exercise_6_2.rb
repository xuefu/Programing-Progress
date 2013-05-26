movies = {
    xuefu: 3,
    xuefu_sh: 4,
    xuefu_zhang: 5
}

puts "--display     display all movies"
puts "--update      update the movie"
puts "--add         add one movie"
puts "--delete      delete one movie"

choice = gets.chomp.downcase

case choice 
when "display"
  puts "All of movies and its rating is: "
  movies.each do |movie,rating|
    puts movie.to_s + ": " + rating.to_s
  end
when "update"
  puts "Please input the title of movie you want to update: "
  title = gets.chomp
  if movies[title.intern].nil?
    puts "Sorry, you input a nil title of movie !"
  else
    puts "Please input the new rating of #{title}: "
    rating = gets.chomp
    movies[title.to_sym] = rating.to_i
  end
when "add"
  puts "Please input the title of movie you want to add: "
  title = gets.chomp
  if movies[title.to_sym].nil?
  puts "Please input the rating of the movie you just input: "
  rating = gets.chomp
  movies[title.to_sym] = rating.to_i
  puts "Greatful, you have add one movie titled #{title}, whose rating is #{rating} !"
  else
    puts "Sorry, you have input the movie and the rating of #{title} is #{movies[titile]} !"
  end
  
when "delete"
  puts "Please input the title of movie you want to delete !"
  title = gets.chomp
  if movies[title.to_sym].nil?
    puts "The title of movie is not existing !"
  else
    movies.delete(title.intern)
  end
else
  puts "Error!"
end
