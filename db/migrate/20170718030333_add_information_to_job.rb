class AddInformationToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :company, :text
    add_column :jobs, :city, :text
    add_column :jobs, :experience, :text
  end
end
