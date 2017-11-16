require 'rest-client'
require 'JSON'
require 'pry'

# def grab_data_from_api(keyword)
#   i = 1
#   data_1 = JSON.parse(RestClient.post('https://us.jooble.org/api/9a43697f-524f-498c-a367-797f250450fd', {"content": '{"keywords": "' + keyword + '", "salary": "100000", "page": "1" }'}))
#   count = (data_1["totalCount"] / 20).ceil
#   data_arr = []
#   while i < count
#     data = JSON.parse(RestClient.post('https://us.jooble.org/api/9a43697f-524f-498c-a367-797f250450fd', {"content": '{"keywords": "' + keyword + '", "salary": "100000", "page": '"#{i}"' }'}))
#     data_arr << data["jobs"]
#     i += 1
#   end
#   data_arr.flatten!
# end



def location_valid?(city_name)
  #binding.pry
  if Job.all.map {|inst| inst.location.downcase.include?(city_name.downcase)}.include?(true)
    return city_name
  else
    false
  end
end

def find_job_by_city(city_name)
  Job.where(location: city_name).count
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
  end

  def self.salary_question(input)
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

  def self.order_by_salary
    highest_paying_job = JobCompanyCard.order(:salary).reverse.first
    puts highest_paying_job.job.title
    puts highest_paying_job.company.name
    puts "$" + "#{highest_paying_job.salary}"
    puts highest_paying_job.description
  end
end
