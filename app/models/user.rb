class User < ActiveRecord::Base
  has_many :user_job_cards
  has_many :job_company_cards, through: :user_job_cards
end
