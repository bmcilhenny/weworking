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
  data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/759fd027-a350-49f9-975f-71427c42165e', {"content": '{"keywords": "' + keyword + '", "salary": "100000", "page": "1" }'}))
  count = (data_1["totalCount"] / 20).ceil
  data_arr = []
  while i < count
    data = JSON.parse(RestClient.post('https://us.jooble.org/api/759fd027-a350-49f9-975f-71427c42165e', {"content": '{"keywords": "' + keyword + '", "salary": "100000", "page": '"#{i}"' }'}))
    data_arr << data["jobs"]
    i += 1
  end
  data_arr.flatten!
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
# binding.pry

def count_job_by_city(city_name, keyword)
  num = Job.all.select { |inst| inst.location.include?(city_name) && inst.title.include?(keyword)  }.length
  puts "There are #{num} jobs in #{city_name}"
end


def salary_question(input, keyword, my_city)
  if input == "y"
    order_by_salary(keyword, my_city)
  elsif input == "n"
    exit
  elsif input != "y" || "n"
    "Please input again"
    new_input = gets.chomp
    salary_question(new_input)
  end
end

def order_by_salary(keyword, city)
  jobcc_arr = JobCompanyCard.all.select do |inst|
    inst.job.title.include?(keyword) && inst.job.location.include?(city)
  end
#array of instances
  highest_inst = jobcc_arr.sort_by{|inst| inst.salary}.reverse.first

  puts highest_inst.job.title
  puts highest_inst.company.name
  puts "$" + "#{highest_inst.salary}"
  puts highest_inst.description
end
