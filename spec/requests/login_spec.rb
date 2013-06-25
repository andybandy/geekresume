require 'spec_helper'

describe "Auth" do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }
  it { should be_valid }
end
