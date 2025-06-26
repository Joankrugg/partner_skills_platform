class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :scheduled_time, :status, presence: true
  validates :status, inclusion: { in: %w[pending confirmed canceled completed] }
end
