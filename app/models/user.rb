class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  enum role: [ :member, :owner ]

  def full_name
    "#{first_name} #{last_name}"
  end

end
