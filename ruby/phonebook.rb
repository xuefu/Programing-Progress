#Solution for http://www.codecademy.com/groups/all-codecademists/discussions/519740bafd2ea03dad002701
#Prepared by Richard Wilson (Ruby v1.9.3)
require 'CSV'
#This solution uses the CSV library, because I wanted to become more comfortable with it.
#It is included in the Ruby Standard Library.
#Using the File class would be just as valid...

#The format of the file generated/used by this class is:
# Name,Sex,Age
# Richard,Male,22
# etc

#The following will show debug messages if set to true via the command line.
$DEBUG = ARGV.empty? ? false : ARGV[0]

class PhoneBook
  attr_reader :file_name
  @@start_dir = ""

  #Intialization Method, set the file name, write headers if we're writing to a fresh file.
  def initialize(file_name)
    @file_name = @@start_dir + file_name
    unless File.exist?(@file_name)
      _write_headers
    end
    self
  end

  #Used for changing the working file of the object, so we dont need to create more objects than necessary.
  def change_file(file_name)
    initialize(file_name)
  end

  #Helper functions to access @@start_dir and set its value.
  def self.start_dir
    @@start_dir
  end

  def self.start_dir=(dirr)
    @@start_dir = dirr
  end

  #Displays the contents of the file in the format Name, Sex, Age.
  def display
    csv = _open('r', headers: true)
    csv.each do |row|
      puts "Name: #{row['Name']} Sex: #{row['Sex']} Age: #{row['Age']}" 
    end
    csv.close
  end

  #Adds an entry to the file
  def add_entry(name, sex, age)
    puts "DEBUG MSG: Adding: #{name}..." if $DEBUG
    _open('a+') {|csv| csv << [name, sex, age]}
  end

  #Deletes an entry based on the name. TODO: Allow for lookups with sex and age.
  def delete_entry(name)
    puts "DEBUG MSG: Deleting #{name}.." if $DEBUG
    begin
      File.open("#{@file_name}.tmp", 'w') do |out_file|
        File.open(@file_name, 'r+') do |file|
          file.each do |line|
            unless line =~ /^#{name},/
              out_file.print line
            else
              puts "Deleted #{line}!"
            end
          end
        end
      end
      #The call below just makes sure that all Files are closed before File.delete because I had some issues with
      #Garbage collection earlier, see link below
      #http://stackoverflow.com/questions/16642609/file-delete-throws-errnoeaccess-permission-denied-in-ruby?noredirect=1#comment23936462_16642609
      ObjectSpace.each_object(File) { |f| puts "DEBUG MSG: " + f.inspect if f.path == @file_name && !f.closed? } if $DEBUG
      File.delete(@file_name)
      File.rename("#{@file_name}.tmp", @file_name)
    rescue Exception
      puts "Exception thrown in PhoneBook::delete_entry(#{name}): #{$!}"
    end
  end

  #The beauty of the CSV library is here, you can lookup any value in any column. 
  def lookup(col, val)
    puts "DEBUG MSG: Looking up #{val}.." if $DEBUG
    results = Array.new
    f = _open('r', headers: true)
    f.each do |row|
      if row[col] == val
        puts "DEBUG MSG: Result Found! #{row[col].inspect}" if $DEBUG
        results << row.fields
      end
    end
    f.close 
    results
  end

  protected

  def _open(*args)
    puts "DEBUG MSG: Open Called!" if $DEBUG
    begin
      if block_given?
        CSV.open(@file_name, *args) do |csv|
          yield csv
        end
      else
        CSV.open(@file_name, *args)
      end
    rescue Exception
      puts "Exception thrown in PhoneBook::_open: #{$!}"
    end
  end

  def _write_headers
    puts "DEBUG MSG: File doesnt exist, creating new file #{@file_name}.." if $DEBUG
    _open('w+') {|csv| csv << ["Name", "Sex", "Age"]}
  end

end

#Set the start directory for future instances. This is where the phonebooks will be stored.
PhoneBook.start_dir = "phonebooks/"
#Create a new phonebook, add three entries to it.
pb = PhoneBook.new("Example.pb")
pb.add_entry("Midori", "Female", "22")
pb.add_entry("Mike", "Male", "34")
pb.add_entry("Lonnie","Female", "23")
#Print out what we have so far.
pb.display 
#We don't like Mike, so lets get rid of him
pb.delete_entry("Mike")
#Make sure he's deleted..
pb.display
#Lets add some more names!
(1..10).each {|n| pb.add_entry("Name" + n.to_s, "Asexual", (20 + n).to_s)}
#Let's lookup everyone who is 23 years old and print them to the console!
puts pb.lookup("Age", "23")
#TODO: Add support for any type of headers, and more data checking.
=begin
File contents at the end of this execution is:
Name,Sex,Age
Midori,Female,22
Lonnie,Female,23
Name1,Asexual,21
Name2,Asexual,22
Name3,Asexual,23
Name4,Asexual,24
Name5,Asexual,25
Name6,Asexual,26
Name7,Asexual,27
Name8,Asexual,28
Name9,Asexual,29
Name10,Asexual,30
=end
