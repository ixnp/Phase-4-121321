class Ticket < ApplicationRecord
  belongs_to :production
  belongs_to :user

  validates :price, numericality: {greater_than_or_equal_to: 0}
end
