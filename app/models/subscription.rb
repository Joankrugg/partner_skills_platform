class Subscription < ApplicationRecord
  belongs_to :user

  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w[active inactive canceled] }
end
