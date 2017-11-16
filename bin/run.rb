require_relative '../config/environment.rb'
require_relative '../lib/api.rb'

puts "Choose a job you are interested in: Software Engineer, Project Manager, or Developer."
keyword = gets.chomp

#Once location is valid
puts "Where are you looking to work? Please enter the city name."
location = gets.chomp


location_valid?(location)

#grab all data given user's location
#binding.pry
#populate database given that location
puts "Great, you're looking for jobs in #{location_valid?(location)}!"
#display to the user how many jobs are in that city
find_job_by_city(location_valid?(location))

puts "Would you like to know the highest paying job in #{location_valid?(location)}? (y/n)"
input = gets.chomp
SalaryHelperMethods.salary_question(input)
