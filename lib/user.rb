require 'pry'

def add_user(name)
  new_user = User.find_or_create_by(name: name)
end

def save_job?(user, job)
  UserJobCard.find_or_create_by(user: User.find_by(name: user), job_company_card: JobCompanyCard.find_by(job: job.job))
end

def list_jobs_saved(user)
  jobs = UserJobCard.all.select {|inst| inst.user.name == user}
  jobs.each do |job_inst|
    puts "#{job_inst.job_company_card.job.title}, #{job_inst.job_company_card.company.name}, #{job_inst.job_company_card.job.location}, $#{job_inst.job_company_card.salary}"
  end
end

def save_job_answer(user, answer, to_save_arr)
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
    exit
  end
end

def answer_to_see_jobs(y_n, user)
  if y_n == "y"
    list_jobs_saved(user)
  elsif y_n == "n"
    exit
  end
end
