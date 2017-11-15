require 'rest-client'
require 'JSON'
require 'pry'

def grab_data_from_api
  i = 1
  data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": "1" }'}))
  count = (data_1["totalCount"] / 20).ceil
  data_arr = []
  while i < count
    data = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": '"#{i}"' }'}))
    data_arr << data["jobs"]
    i += 1
  end
  data_arr.flatten!
end


binding.pry

def populate_seed_file(all_job_data)
  all_job_data.each do |individual_job_hash|
    job = Job.create(title: individual_job_hash['title'], location: individual_job_hash['location'])
    company = Company.create(name: individual_job_hash['company'])
    JobCompanyCard.create(job: job, company: company, salary: individual_job_hash['salary'], description: individual_job_hash['snippet'])
  end
end
