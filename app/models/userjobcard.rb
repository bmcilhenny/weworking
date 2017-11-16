class UserJobCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :job_company_card
end
