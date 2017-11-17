require 'pry'
require_relative './api.rb'

class UserMethod
  def self.user_exists?(name)
    if User.exists?(:name => name)
      true
    else
      false
    end
  end

  def self.add_user(name)
    new_user = User.find_or_create_by(name: name)
  end

  def self.answer_to_see_jobs(y_n, user)
    if y_n == "y"
      list_jobs_saved(user)
    elsif y_n == "n"
      UserMethod.exit?
    end
  end

  def self.list_jobs_saved(user)
    jobs = UserJobCard.all.select {|inst| inst.user.name == user}
    counter = 0
    jobs.each do |job_inst|
      puts "#{counter + 1}. #{job_inst.job_company_card.job.title}, #{job_inst.job_company_card.company.name}, #{job_inst.job_company_card.job.location}, $#{job_inst.job_company_card.salary}"
      counter +=1
    end
    #binding.pry
    sleep(1)
    puts "Select a number to view that job's description."
    user_input = gets.chomp
    if user_input.downcase == 'exit'
      exit?
    elsif user_input.to_i > jobs.length
      system("clear")
      puts "Invalid number. Try again."
      sleep(1)
      list_jobs_saved(user)
    else
      system("clear")
      puts jobs[user_input.to_i - 1].job_company_card.description
      sleep(1)
      puts "----------------------------------------------------------------"
      puts "Type 'back' to return to see other job descriptions. Type anything else to continue the job search."
      user_input = gets.chomp
      if user_input == 'back'
        list_jobs_saved(user)
      end
    end
  end

  def self.number_of_jobs_saved(user)
    UserJobCard.all.select {|inst| inst.user.name == user}.length
  end

  def self.exit?
    puts "Would you like to start over or exit the app? (start over/exit)"
    input = gets.chomp
    if input == "start over"
      run
    elsif input == "exit"
      puts "Good Bye!"
      exit
    end
  end

end

class JobMethod

  def self.save_job_answer(user, answer, to_save_arr)
    if answer == "1"
      save_job?(user, to_save_arr[0])
    elsif answer == "2"
      save_job?(user, to_save_arr[1])
    elsif answer == "3"
      save_job?(user, to_save_arr[2])
    elsif answer == "4"
      save_job?(user, to_save_arr[3])
    elsif answer == "5"
      save_job?(user, to_save_arr[4])
    elsif answer == "none"
      UserMethod.exit?
    end
  end

  def self.save_job?(user, job)
    UserJobCard.find_or_create_by(user: User.find_by(name: user), job_company_card: JobCompanyCard.find_by(job: job.job))
  end

end
