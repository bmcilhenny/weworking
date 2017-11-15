require 'rest-client'
require 'JSON'
require 'pry'
#binding.pry

i = 1
data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": '"#{1}"' }'}))
count = (data_1["totalCount"] / 20).ceil

data_arr = []
while i < count
  data = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": '"#{i}"' }'}))
  data_arr << data["jobs"]
  i += 1
end
all_job_data = data_arr.flatten!

#binding.pry

# true

# order job by salary
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

def salary_to_integer
  JobCompanyCard.all.map { |inst| inst.salary  }

end

def order_by_salary
  JobCompanyCard.order(salary: :desc).first
end
