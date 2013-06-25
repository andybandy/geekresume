require 'spec_helper'

describe "Auth" do
  let(:user) { FactoryGirl.create(:user) }

  it "allows user to login" do
   sign_in(user)
   page.should have_content("Резюме")
  end
end
