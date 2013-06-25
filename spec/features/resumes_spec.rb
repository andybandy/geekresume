require 'spec_helper'

describe "Resumes" do
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in(user) }
  context "creating new resume" do
    it "allows to create new resume" do
      click_link "Новое резюме"
      current_path.should eq(new_resume_path)

      resume_title = "Ruby developer"
      fill_in "resume_title", with: resume_title
      click_button 'Создать'
      page.should have_content(resume_title)
    end
  end
end
