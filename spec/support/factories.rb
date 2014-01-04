FactoryGirl.define do
  factory :building do
    street_address '100 Main Street'
    city 'Boston'
    state 'MA'
    zip_code '02118'
    description 'Mixed commercial/residential space'

    association :owner
  end

  factory :owner do
    first_name 'Michael'
    last_name 'Bluth'
    sequence(:email) { |n| "bananastand#{n}@cornballer.com" }
    company 'Sudden Valley Properties'
  end
end
