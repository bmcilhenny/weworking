require_relative '../config/environment.rb'
require_relative '../lib/api.rb'

def run
  system("clear")
  puts "o          `O                             o                    "
  puts "O           o                             O     o              "
  puts "o           O                             o                    "
  puts "O           O                             o                    "
  puts "o     o     o .oOo. 'o     O .oOo. `OoOo. O  o  O  'OoOo. .oOoO"
  puts "O     O     O OooO'  O  o  o O   o  o     OoO   o   o   O o   O"
  puts "`o   O o   O' O      o  O  O o   O  O     o  O  O   O   o O   o"
  puts "`OoO' `OoO'  `OoO'  `Oo'oO' `OoO'  o     O   o o'  o   O `OoOo"
  puts "                                                             O  "
  puts "                                                         OoO' "

  puts "Welcome to Weworking. If you would like to exit the program at any time type 'exit'. Looking to start over? Type 'start over'."
  puts "Hi! Please enter your name:"

  user = gets.chomp.titleize

  if user == "exit"
    puts "Goodbye!"
    exit
  elsif user == "start over"
    puts "start over"
    run
  end

  if UserMethod.user_exists?(user)
      puts "Welcome back #{user}! You have #{UserMethod.number_of_jobs_saved(user)} saved jobs."
      sleep(3)
  else
      puts "Greetings #{user}!"
      sleep(3)
      UserMethod.add_user(user)
  end


  puts "Choose a job you are interested in: Software Engineer, Project Manager, or Developer."
  sleep(3)
  keyword = gets.chomp.titleize

  if keyword == "exit"
    puts "Goodbye!"
    exit
  elsif keyword == "start over"
    puts "start over"
    run
  end

  my_keyword = valid_keyword?(keyword)
  #Once location is valid

  puts "Where are you looking to work? Please enter the city name. Need some help deciding where to look? Here is the list of the five cities with the most jobs:"
  sleep(2)
  JobStats.top_five_cities_most_x_jobs(my_keyword)

  location = gets.chomp.titleize

  if location == "exit"
    puts "Goodbye!"
    exit
  elsif location == "start over"
    puts "start over"
    run
  end

  my_city = location_valid?(location)

  #grab all data given user's location
  #binding.pry
  #populate database given that location
  puts "Great, you're looking for jobs in #{my_city}!"
  #display to the user how many jobs are in that city
  count_job_by_city(my_city, my_keyword)
  sleep(4)

  puts "Would you like to know the highest paying jobs in #{my_city}? (y/n)"

  input = gets.chomp

  if input == "exit"
    puts "Goodbye!"
    exit
  elsif input == "start over"
    puts "start over"
    run
  end

  SalaryHelperMethods.salary_question(input, my_keyword, my_city)

  sleep(3)

  puts "Which of these jobs would you like to save?(pick 1/2/3/4/5/none)"

  to_save_arr = SalaryHelperMethods.array_of_salary_inst(my_keyword, my_city)

  #binding.pry
  answer = gets.chomp

  if answer == "exit"
    puts "Goodbye!"
    exit
  elsif answer == "start over"
    puts "start over"
    run
  end

  JobMethod.save_job_answer(user, answer, to_save_arr)

  puts "Would you like to see all your saved jobs? (y/n)"

  y_n = gets.chomp

  if y_n == "exit"
    puts "Goodbye!"
    exit
  elsif y_n == "start over"
    puts "start over"
    run
  end

  UserMethod.answer_to_see_jobs(y_n, user)

  UserMethod.exit?

end

run
