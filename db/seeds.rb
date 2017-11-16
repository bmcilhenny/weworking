require_relative '../lib/api.rb'

class API
  def self.grab_data_from_api
    position_array = ["Software Engineer", "Product Manager", "Web Developer"]
    entire_dataset = []
    position_array.each do |position|

      i = 1
      data_arr = []

      data_for_this_position = JSON.parse(RestClient.post('https://us.jooble.org/api/759fd027-a350-49f9-975f-71427c42165e', {"content": '{"keywords": "' + position + '", "salary": "100000", "page": "1" }'}))

      count = ((data_for_this_position["totalCount"] / 20).ceil)/2

      JSON.parse(RestClient.post('https://us.jooble.org/api/759fd027-a350-49f9-975f-71427c42165e', {"content": '{"keywords": "' + position + '", "salary": "100000", "page": "1" }'}))

      while i < count
        data = JSON.parse(RestClient.post('https://us.jooble.org/api/759fd027-a350-49f9-975f-71427c42165e', {"content": '{"keywords": "' + position + '", "salary": "100000", "page": '"#{i}"' }'}))
        data_arr << data["jobs"]
        i += 1
      end
    entire_dataset << data_arr.flatten!
    end
    entire_dataset.flatten!
  end

  def self.populate_seed_file
    #call the grab_data_from_api
    API.grab_data_from_api.each do |individual_job_hash|
      job = Job.find_or_create_by(title: individual_job_hash['title'], location: individual_job_hash['location'])
      company = Company.find_or_create_by(name: individual_job_hash['company'])
      JobCompanyCard.find_or_create_by(job: job, company: company, salary: SalaryHelperMethods.str_to_i(individual_job_hash['salary']), description: individual_job_hash['snippet'])
    end
  end
end

Job.destroy_all
Company.destroy_all
JobCompanyCard.destroy_all

API.populate_seed_file
