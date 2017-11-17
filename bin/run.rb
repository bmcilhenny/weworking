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
  sleep(2)
  puts "Welcome to Weworking. If you would like to exit the program at any time type 'exit'. Looking to start over? Type 'start over'."
  puts "Hi! Please enter your name:"

  user = gets.chomp.titleize

  if user.downcase == "exit"
    puts "Goodbye!"
    exit
  elsif user.downcase == "start over"
    puts "starting over.."
    run
  end

  if UserMethod.user_exists?(user)
      puts "Welcome back #{user}! You have #{UserMethod.number_of_jobs_saved(user)} saved job(s)."
      sleep(3)
  else
      puts "Greetings #{user}!"
      sleep(3)
      UserMethod.add_user(user)
  end
  #can now grab the job descriptions through job_data
  user_instance = User.find_by(name: user)

  puts "Choose a job you are interested in: Software Engineer, Project Manager, or Developer."
  sleep(3)
  keyword = gets.chomp.titleize

  if keyword.downcase == "exit"
    sleep(1)
    puts "Goodbye!"
    exit
  elsif keyword.downcase == "start over"
    sleep(1)
    puts "starting over.."
    run
  end

  my_keyword = valid_keyword?(keyword)
  #Once location is valid

  puts "Where are you looking to work? Please enter the city name. Need some help deciding where to look? Here is the list of the five cities with the most jobs:"
  sleep(2)
  JobStats.top_five_cities_most_x_jobs(my_keyword)

  location = gets.chomp.titleize

  if location.downcase == "exit"
    puts "Goodbye!"
    sleep(1)
    exit
  elsif location.downcase == "start over"
    puts "start over"
    sleep(1)
    run
  end

  my_city = location_valid?(location)
  sleep(2)

  #grab all data given user's location
  #binding.pry
  #populate database given that location
  #puts "Great, you're looking for jobs in #{my_city}!"
  #display to the user how many jobs are in that city
  count_job_by_city(my_city, my_keyword)
  sleep(2)

  puts "Would you like to know the highest paying jobs in #{my_city}? (y/n)"

  input = gets.chomp

  if input == "exit"
    puts "Goodbye!"
    sleep(1)
    exit
  elsif input == "start over"
    puts "starting over.."
    sleep(1)
    run
  end

  SalaryHelperMethods.salary_question(input, my_keyword, my_city)
  sleep(2)
  puts "Which of these jobs would you like to save?(pick 1/2/3/4/5/none)"
  to_save_arr = SalaryHelperMethods.array_of_salary_inst(my_keyword, my_city)

  answer = gets.chomp
  #refactored this gets.chomp to handle entries that are greater than the number of jobs
  until SalaryHelperMethods.valid_choice?(my_keyword, my_city, answer, to_save_arr)
    puts "Invalid entry. Please try again."
    answer = gets.chomp
    SalaryHelperMethods.valid_choice?(my_keyword, my_city, answer, to_save_arr)
  end

  sleep(2)

  JobMethod.save_job_answer(user, answer, to_save_arr)

  puts "Would you like to see all your saved jobs? (y/n)"

  y_n = gets.chomp

  if y_n == "exit"
    sleep(2)
    puts "Goodbye!"
    exit
  elsif y_n == "start over"
    sleep(2)
    puts "starting over.."
    run
  end

  UserMethod.answer_to_see_jobs(y_n, user)
  sleep(2)

  UserMethod.exit?

end

run
