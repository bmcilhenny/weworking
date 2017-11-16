require_relative '../config/environment.rb'
require_relative '../lib/api.rb'

def run
  puts "What's your name?"
  user_name = gets.chomp

  if user_exists
    "Welcome back #{user_name}!"
  else
    add_user(user_name)
  end

  puts "Choose a job you are interested in: Software Engineer, Project Manager, or Developer."
  keyword = gets.chomp

  #if the user want to see jobs in the cities with the most openings show them, else don't.
  puts "Would you like to see the cities with the most #{keyword} openings? (y/n)"
  user_input = gets.chomp
  if user_input.downcase == 'y'
    JobStats.top_five_cities_most_x_jobs(keyword)
  else
    puts "Don't care about the data-trend? So open-minded of you!"
  end

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

  puts "Would you like to know the highest paying job in #{my_city}? (y/n)"

  input = gets.chomp
  SalaryHelperMethods.salary_question(input, keyword, my_city)

  puts "Want to add job to your saved jobs? (y/n)"
  new_user_input = gets.chomp

  if new_user_input == 'y'
    save_job?
  else
    rerun program
  end
end
