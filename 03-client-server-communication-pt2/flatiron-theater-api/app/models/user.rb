class User < ApplicationRecord
    has_many :tickets
    has_many :productions, through: :tickets

    validates :name, presence: true, uniqueness: true
    validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, presence: true, uniqueness:true

    #TODO: Custom Validation
end
