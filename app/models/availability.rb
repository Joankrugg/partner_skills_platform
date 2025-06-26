class Availability < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, presence: true
  validate :end_after_start

  private

  def end_after_start
    if start_time.present? && end_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
