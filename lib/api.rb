require 'rest-client'
require 'JSON'
require 'pry'

# data = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": "1" }'}))


def is_location_valid?(location)
  begin
    #binding.pry
    JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "' + location + '", "salary": "100000", "page": "1" }'}))
    true
  rescue => e
    puts "You either spelled your city wrong or the data is not available for that city. Please reenter your city."
    new_entry = gets.chomp
    location = new_entry
    is_location_valid?(location)
  end
end

def grab_data_from_api(location)
  i = 1
  data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "' + location + '", "salary": "100000", "page": "1" }'}))
  count = (data_1["totalCount"] / 20).ceil
  data_arr = []
  while i < count
    data = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "' + location + '", "salary": "100000", "page": '"#{i}"' }'}))
    data_arr << data["jobs"]
    i += 1
  end
  data_arr.flatten!
end

def how_many_jobs_in_that_city(location)
  data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "' + location + '", "salary": "100000", "page": "1" }'}))
  puts "There are a total of #{data_1["totalCount"]} jobs in this city."
end

#binding.pry

def populate_seed_file(all_job_data)
  all_job_data.each do |individual_job_hash|
    job = Job.create(title: individual_job_hash['title'], location: individual_job_hash['location'])
    company = Company.create(name: individual_job_hash['company'])
    JobCompanyCard.create(job: job, company: company, salary: individual_job_hash['salary'], description: individual_job_hash['snippet'])
  end
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
  puts highest_paying_job.salary
  puts highest_paying_job.description
end
