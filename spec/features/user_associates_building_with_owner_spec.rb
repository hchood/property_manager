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
    owner = FactoryGirl.create(:owner)
    building = FactoryGirl.build(:building, owner: nil)

    visit '/'
    click_on 'Add Building'

    fill_in 'Street Address', with: building.street_address
    fill_in 'City', with: building.city
    fill_in 'State', with: building.state
    fill_in 'Zip Code', with: building.zip_code
    fill_in 'Description', with: building.description
    select owner.name, from: 'Owner'
    click_button 'Create Building'

    # it creates the building
    expect(page).to have_content 'Successfully recorded building!'
    expect(Building.all.count).to eq 1

    # the building has the correct associated owner
    expect(Building.first.owner_name).to eq owner.name
  end

  it "deletes a building's owner when owner is deleted" do
    building = FactoryGirl.create(:building)
    owner = building.owner

    visit '/'
    click_on 'View Owners'
    click_on 'Delete'

    expect(Owner.all.count).to eq 0
    expect(Building.first.owner).to be_nil
  end
end
