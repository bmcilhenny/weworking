class Company < ActiveRecord::Base
  has_many :jobcompanycards
  has_many :jobs, through: :jobcompanycards
end
