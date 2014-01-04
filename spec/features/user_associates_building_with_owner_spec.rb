require 'spec_helper'

feature 'User associates building with owner', %Q{
  As a real estate associate
  I want to correlate an owner with buildings
  So that I can refer back to pertinent information
} do

  # Acceptance Criteria:

  # * When recording a building, I want to optionally associate the
  # building with its rightful owner.
  # * If I delete an owner, the owner and its primary key
  # should no longer be associated with any properties.


  it 'creates a building with an associated owner' do
    building = FactoryGirl.build(:building)

    visit '/'
    click_on 'Add Building'

    fill_in 'Street Address', with: building.street_address
    fill_in 'City', with: building.city
    fill_in 'State', with: building.state
    fill_in 'Zip Code', with: building.zip_code
    fill_in 'Description', with: building.description
    select building.owner_name, from: 'Owner'
    click_button 'Create Building'
  end

  it "deletes a building's owner when owner is deleted"
end
