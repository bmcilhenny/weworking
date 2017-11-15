require_relative '../config/environment.rb'
require_relative '../lib/api.rb'

puts "Hola! Where are you looking to work? Please enter the city name."
location = gets.chomp

#Once location is valid
while !is_location_valid?(location)
  is_location_valid?(location)
end

#grab all data given user's location
grab_data_from_api(location)
#binding.pry
#populate database given that location
populate_seed_file(grab_data_from_api(location))
puts "Great, you're looking for jobs in #{location}!"
#display to the user how many jobs are in that city
how_many_jobs_in_that_city(location)
puts "Would you like to know the highest paying job in #{location}? (y/n)"

input = gets.chomp
salary_question(input)
