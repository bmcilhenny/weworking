require_relative 'config/environment'
require_relative '../lib/api.rb'

puts "Hi!, Where are you looking for a job?"

puts "Would you like to know the highest paying job by salary? (y/n)"
input = gets.chomp

salary_question(input)
