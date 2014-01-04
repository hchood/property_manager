class Owner < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }

  def name
    "#{first_name} #{last_name}"
  end
end
