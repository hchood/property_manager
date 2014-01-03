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
    expect(page).to have_content 'Successfully recorded building!'
    expect(Building.all.count).to eq 1

    # it redirects to the new building page
    expect(page).to have_button 'Create Building'
  end

  scenario 'adds building with missing attributes' do
  visit '/'
    click_on 'Add Building'

    click_button 'Create Building'

    # it does not creates the building
    expect(page).to have_content 'Uh oh!  We ran into some errors.'
    expect(Building.all.count).to eq 0

    # it displays error messages
    within '.input.building_street_address' do
      expect(page).to have_content "can't be blank"
    end

    within '.input.building_city' do
      expect(page).to have_content "can't be blank"
    end

    within '.input.building_state' do
      expect(page).to have_content "can't be blank"
    end

    within '.input.building_zip_code' do
      expect(page).to have_content "can't be blank"
    end

    # it renders the new building page again
    expect(page).to have_button 'Create Building'
  end

  scenario 'adds building with invalid state and zip code' do
    building = FactoryGirl.build(:building, state: 'LM', zip_code: '1234abc')

    visit '/'
    click_on 'Add Building'

    fill_in 'Street Address', with: building.street_address
    fill_in 'City', with: building.city
    fill_in 'State', with: building.state
    fill_in 'Zip Code', with: building.zip_code
    fill_in 'Description', with: building.description
    click_button 'Create Building'

    # it does not creates the building
    expect(page).to have_content 'Uh oh!  We ran into some errors.'
    expect(Building.all.count).to eq 0

    # it displays error messages
    within '.input.building_state' do
      expect(page).to have_content 'is not included in the list'
    end

    within '.input.building_zip_code' do
      expect(page).to have_content 'is invalid'
    end

    # it renders the new building page again
    expect(page).to have_button 'Create Building'
  end
end
