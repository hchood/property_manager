require 'spec_helper'

describe Building do
  STATES =  %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  it { should validate_presence_of :street_address }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :zip_code }

  it { should have_valid(:state).when('MA', 'CA', 'NY', 'DC') }
  it { should_not have_valid(:state).when('Ontario', 'XY') }

  it { should have_valid(:zip_code).when('12345', '02139') }
  it { should_not have_valid(:zip_code).when('abc', '2139', '@#!12345') }
end
