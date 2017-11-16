require_relative '../config/environment.rb'
require_relative '../lib/api.rb'

puts "Hi! Please enter your name:"

user = gets.chomp
add_user(user)

puts "Choose a job you are interested in: Software Engineer, Project Manager, or Developer."
keyword = gets.chomp

#Once location is valid
puts "Where are you looking to work? Please enter the city name."
location = gets.chomp
my_city = location_valid?(location)

#grab all data given user's location
#binding.pry
#populate database given that location
puts "Great, you're looking for jobs in #{my_city}!"
#display to the user how many jobs are in that city
count_job_by_city(my_city, keyword)

puts "Would you like to know the highest paying jobs in #{my_city}? (y/n)"

input = gets.chomp
SalaryHelperMethods.salary_question(input, keyword, my_city)

puts "Which of these jobs would you like to save?(pick 1/2/3/4/5/none)"

to_save_arr = SalaryHelperMethods.array_of_salary_inst(keyword, my_city)

#binding.pry
answer = gets.chomp

save_job_answer(user, answer, to_save_arr)

puts "Would you like to see all your saved jobs? (y/n)"

y_n = gets.chomp

answer_to_see_jobs(y_n, user)
