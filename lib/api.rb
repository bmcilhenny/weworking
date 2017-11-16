require 'rest-client'
require 'JSON'
#require 'csv'
require 'pry'

# data = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": "1" }'}))




# def is_location_valid?(location)
#   if location == nil
#     puts "Please type a city name."
#   else
#     begin
#       #binding.pry
#       JSON.parse(RestClient.post('https://us.jooble.org/api/9a43697f-524f-498c-a367-797f250450fd', {"content": '{"keywords": "software engineer", "location": "' + location + '", "salary": "100000", "page": "1" }'}))
#       true
#     rescue
#       binding.pry
#       puts "You either spelled your city wrong or the data is not available for that city. Please reenter your city."
#       new_entry = gets.chomp
#       location = new_entry
#       is_location_valid?(location)
#     end
#   end
# end

def grab_data_from_api(keyword)
  i = 1
  data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/9a43697f-524f-498c-a367-797f250450fd', {"content": '{"keywords": "' + keyword + '", "salary": "100000", "page": "1" }'}))
  count = (data_1["totalCount"] / 20).ceil
  data_arr = []
  while i < count
    data = JSON.parse(RestClient.post('https://us.jooble.org/api/9a43697f-524f-498c-a367-797f250450fd', {"content": '{"keywords": "' + keyword + '", "salary": "100000", "page": '"#{i}"' }'}))
    data_arr << data["jobs"]
    i += 1
  end
  data_arr.flatten!
end

def how_many_jobs_in_that_city(keyword, location)
  data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/9a43697f-524f-498c-a367-797f250450fd', {"content": '{"keywords": "' + keyword + '", "location": "' + location + '", "salary": "100000", "page": "1" }'}))
  puts "There are a total of #{data_1["totalCount"]} jobs in this city."
end

#binding.pry

def str_to_i(sal_str)
  sal_arr = sal_str.split(" ").delete_if{|x| x == "-" || x == "per" || x == "hour"}
  if sal_arr.length == 1 && sal_arr[0].include?("$" && "k")
    sal_arr.join("").delete("$").sub!("k", "000").to_i
  elsif sal_arr.length == 1 && sal_arr[0].include?("$")
    sal_arr.join("").delete("$").to_i
  elsif sal_arr.length == 2
    sal_arr.map { |str| str.delete("$").sub!("k", "000").to_i}.flatten.reduce(:+) / 2
  end
end

def populate_seed_file(all_job_data)
  all_job_data.each do |individual_job_hash|
    job = Job.find_or_create_by(title: individual_job_hash['title'], location: individual_job_hash['location'])
    company = Company.find_or_create_by(name: individual_job_hash['company'])
    JobCompanyCard.find_or_create_by(job: job, company: company, salary: str_to_i(individual_job_hash['salary']), description: individual_job_hash['snippet'])
  end
end

def location_valid?(city_name)
  if Job.all.each {|inst| inst.location.downcase == city_name.downcase} == false
    puts "Please enter a valid city:"
    new_input = gets.chomp
    location_valid?(new_input)
  else
    return city_name
  end
end
# binding.pry

def find_job_by_city(city_name)
  Job.where(location: city_name).count
end


def salary_question(input)
  if input == "y"
    order_by_salary
  elsif input == "n"
    exit
  elsif input != "y" || "n"
    "please input again"
    new_input = gets.chomp
    salary_question(new_input)
  end
end

def order_by_salary
  highest_paying_job = JobCompanyCard.order(:salary).reverse.first
  puts highest_paying_job.job.title
  puts highest_paying_job.company.name
  puts "$" + "#{highest_paying_job.salary}"
  puts highest_paying_job.description
end
