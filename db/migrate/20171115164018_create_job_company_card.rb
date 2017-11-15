class CreateJobCompanyCard < ActiveRecord::Migration[5.0]
  def change
    create_table :job_company_cards do |t|
      t.integer :job_id
      t.integer :company_id
      t.string :salary
      t.string :description
    end
  end
end
