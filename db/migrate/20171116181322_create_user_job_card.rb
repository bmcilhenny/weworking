class CreateUserJobCard < ActiveRecord::Migration[5.0]
  def change
    create_table :user_job_cards do |t|
      t.integer :user_id
      t.integer :job_company_card_id      
    end
  end
end
