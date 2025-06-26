class Service < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
