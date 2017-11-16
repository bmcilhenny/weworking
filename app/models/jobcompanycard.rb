class JobCompanyCard < ActiveRecord::Base
  belongs_to :job
  belongs_to :company
  has_many :user_job_cards
  has_many :users, through: :user_job_cards
end
