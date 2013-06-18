class ChangeResumes < ActiveRecord::Migration
  def change
    remove_column :resumes, :content
    add_column :resumes, :checksum, :string
  end
end
