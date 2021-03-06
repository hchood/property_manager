class Building < ActiveRecord::Base
  STATES =  %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  validates_presence_of :street_address
  validates_presence_of :city
  validates :state, presence: :true, inclusion: { in: STATES }
  validates :zip_code, presence: :true, format: { with: /\A\d{5}\z/}

  belongs_to :owner

  def owner_name
    if owner.nil?
      ""
    else
      owner.name
    end
  end
end
