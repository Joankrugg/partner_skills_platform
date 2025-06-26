class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :subscription
  # ... devise modules ...

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: %w[client partner] }
  
  def client?
    role == 'client'
  end

  def partner?
    role == 'partner'
  end
  has_one :subscription
  def active_subscription?
    subscription&.status == 'active' && subscription.end_date > Time.current
  end
end
