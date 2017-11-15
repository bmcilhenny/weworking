class ChangeJobCompanyName < ActiveRecord::Migration[5.0]
  def change
    rename_table('jobcompanycards', 'job_company_cards')
  end
end
