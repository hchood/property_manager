require 'spec_helper'

feature 'User records a building', %Q{
  As a real estate associate
  I want to record a building
  So that I can refer back to pertinent information
} do

  # Acceptance Criteria:
  # 1  I must specify a street address, city, state, and postal code
  # 2  Only US states can be specified
  # 3  I can optionally specify a description of the building
  # 4  If I enter all of the required information in the
  # required format, the building is recorded.
  # 5  If I do not specify all of the required information in the
  # required formats, the building is not recorded and I am presented
  # with errors
  # 6  Upon successfully creating a building, I am redirected so that
  # I can record another building.

  scenario 'adds building with valid attributes' do
    building = FactoryGirl.build(:building)

    visit '/'
    click_on 'Add Building'

    fill_in 'Street Address', with: building.street_address
    fill_in 'City', with: building.city
    fill_in 'State', with: building.state
    fill_in 'Zip Code', with: building.zip_code
    fill_in 'Description', with: building.description
    click_button 'Create Building'

    # it creates the building
    expect(page).to have_content 'Successfully created building.'
    expect(Building.all.count).to eq 1

    # it redirects to the new building page
    expect(page).to have_button 'Create Building'
  end

  scenario 'adds building with missing attributes'

  scenario 'adds building with invalid state'

end
