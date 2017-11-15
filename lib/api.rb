require 'rest-client'
require 'JSON'
require 'pry'
#binding.pry
i = 1
data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": "1" }'}))
count = (data_1["totalCount"] / 20).ceil
data_arr = []
while i < count
  hsh = '{"keywords": "software engineer", "location": "New York", "salary": "100000", "page": ' + "#{i}" +'}'
  data = JSON.parse(RestClient.post('https://us.jooble.org/api/c1932510-a81b-4ca7-8b11-7c82f34f417a', {"content": "#{hsh}"}))
  data_arr << data["jobs"]
  i += 1
end
data_arr.flatten!
#binding.pry

true
