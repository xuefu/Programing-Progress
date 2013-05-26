#by chronocalamity

print "What is your name?"
name = gets.chomp.capitalize!
puts "Greetings Professor #{name}, Shall we play a game?"
aone = gets.chomp
aone.capitalize!

def list
    puts "Chess"
    puts "Checkers"
    puts "Tic-Tac-Toe"
    puts "Backgammon"
    puts "Poker"
    puts "Falkin's Maze"
    puts "Global Thermonuclear War"
end

if aone == "Yes"
    puts "Ok Professor #{name} please pick from the following list."
    puts "#{list}"
elsif aone == "No"
    puts "Professor #{name} do you not like games?"
else
    puts "My Responses are limited please reply with Yes or No"
end

pgame = gets.chomp!

if pgame == "Global Thermonuclear War"
    puts "Teh Nukes are incomming"
else
    puts "Please type input exactly as you see it"
end

stop = gets
