require 'spec_helper'

describe Owner do
  let!(:owner) { FactoryGirl.create(:owner) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :email }
  it { should have_valid(:email).when("joeschmo@whocares.com", "me@mywebsite.com") }
  it { should_not have_valid(:email).when('@whocares', 'me@mywebsite', 'something') }

  it { should have_many(:buildings).dependent(:nullify) }
end
