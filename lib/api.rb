require 'rest-client'
require 'JSON'
require 'pry'

def location_valid?(city_name)
  #binding.pry
  if Job.all.map {|inst|
     inst.location.downcase.include?(city_name.downcase)}
     .include?(true)
    return city_name
  else
    puts "Please enter a valid city:"
    new_input = gets.chomp
    location_valid?(new_input)
  end
end

def count_job_by_city(city_name, keyword)
  num = Job.all.select { |inst| inst.location.include?(city_name) && inst.title.include?(keyword) }.length
  puts "There are #{num} jobs in #{city_name}"
end

def valid_keyword?(keyword)
  if keyword == "Software Engineer"
    return keyword
  elsif keyword == "Project Manager"
    return keyword
  elsif keyword == "Developer"
    return keyword
  else
    puts "Please choose from the jobs above:"
    new_keyword = gets.chomp.titleize
    valid_keyword?(new_keyword)
  end
end


class SalaryHelperMethods
  def self.str_to_i(sal_str)
    sal_arr = sal_str.split(" ").delete_if{|x| x == "-" || x == "per" || x == "hour"}
    if sal_arr.length == 1 && sal_arr[0].include?("$" && "k")
      sal_arr.join("").delete("$").sub!("k", "000").to_i
    elsif sal_arr.length == 1 && sal_arr[0].include?("$")
      sal_arr.join("").delete("$").to_i
    elsif sal_arr.length == 2
      sal_arr.map { |str| str.delete("$").sub!("k", "000").to_i}.flatten.reduce(:+) / 2
    end
    #if the new number's length is equal to 2 add two 0s, if the new_number's length is equal to
  end

  def self.salary_question(input, keyword, my_city)
    if input == "y"
      order_by_salary(keyword, my_city)
    elsif input == "n"
      UserMethod.exit?
    elsif input != "y" || "n"
      "Please input again"
      new_input = gets.chomp
      salary_question(new_input, keyword, my_city)
    end
  end

  def self.order_by_salary(keyword, city)
    jobcc_arr = JobCompanyCard.all.select do |inst|
      inst.job.title.include?(keyword) && inst.job.location.include?(city)
    end
  #array of instances
    highest_inst = jobcc_arr.sort_by{|inst| inst.salary}.reverse.first(5)

    highest_inst.each do |inst|
      puts "#{inst.job.title}, #{inst.company.name}, #{inst.job.location}, $#{inst.salary}"
    end
  end

  def self.array_of_salary_inst(keyword, city)
    jobcc_arr = JobCompanyCard.all.select do |inst|
      inst.job.title.include?(keyword) && inst.job.location.include?(city)
    end
  #array of instances
    highest_inst = jobcc_arr.sort_by{|inst| inst.salary}.reverse.slice(0, 4)
  end

#refactored to return true or false
  def self.valid_choice?(my_keyword, my_city, input, to_save_arr)
    if input.to_i > to_save_arr.length
      false
    else
      true
    end
  end

end

class JobStats
  def self.top_five_cities_most_x_jobs(keyword)
    top_five_cities = Job.where("title LIKE ?", "%#{keyword}%").group('location').order('location').count#.first(5)
    puts top_five_cities.sort_by {|key, value| value}.reverse.first(5)
  end

end
