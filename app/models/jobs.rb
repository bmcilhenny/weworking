class Job < ActiveRecord::Base
  has_many :jobcompanycards
  has_many :companies, through: :jobcompanycards
end
