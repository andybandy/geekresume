class AddUserIdToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :user_id, :integer
    add_index :resumes, :user_id
  end
end
