require 'spec_helper'

feature 'User records a building owner', %Q{
  As a real estate associate
  I want to record a building owner
  So that I can keep track of our relationships with owners
} do

  # Acceptance Criteria:

  # I must specify a first name, last name, and email address
  # I can optionally specify a company name
  # If I do not specify the required information, I am presented with errors
  # If I specify the required information, the owner is recorded and I am redirected to enter another new owner

  scenario 'adds owner with valid attributes' do
    owner = FactoryGirl.build(:owner)

    visit '/'
    click_on 'Add Owner'

    fill_in 'First Name', with: owner.first_name
    fill_in 'Last Name', with: owner.last_name
    fill_in 'Email', with: owner.email
    fill_in 'Company', with: owner.company
    click_button 'Create Owner'

    # it creates the owner
    expect(page).to have_content 'Successfully recorded owner!'
    expect(Owner.all.count).to eq 1

    # it redirects to the new owner page
    expect(page).to have_button 'Create Owner'
  end

  scenario 'adds owner with missing attributes' do
    visit '/'
    click_on 'Add Owner'
    click_button 'Create Owner'

    # it does not create the owner
    expect(page).to have_content 'Uh oh!  We encountered a problem.'
    expect(Owner.all.count).to eq 0

    # it renders the new owner form
    expect(page).to have_button 'Create Owner'
  end

end
