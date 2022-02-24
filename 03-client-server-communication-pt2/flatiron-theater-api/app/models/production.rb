class Production < ApplicationRecord
    has_many :production_roles, dependent: :destroy
    has_many :tickets, dependent: :destroy
    has_many :users, through: :tickets, dependent: :destroy

    validates :title, presence: true
    validates :budget, numericality: {greater_than: 0}
end
