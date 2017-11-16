class ChangeSalaryType < ActiveRecord::Migration[5.0]
  def change
    change_column :job_company_cards, :salary, :integer
  end
end
