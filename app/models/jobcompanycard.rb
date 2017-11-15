class JobCompanyCard < ActiveRecord::Base
  belongs_to :job
  belongs_to :company
  
end
