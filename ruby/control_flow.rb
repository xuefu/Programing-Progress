print "Please input a variable: "
user_input = gets.chomp
user_input.downcase!

if user_input == ''

    puts "You input nothing, please input again!"

elsif user_input.include?("s")

    user_input.gsub!(/s/, "th")
    puts "You variable inputted just now is #{user_input} "

else

    puts "You variable inputted just now includes no char s: #{user_input}"

end
