class User < ApplicationRecord
    has_many :tickets
    has_many :productions, through: :tickets

    validates :name, presence: true, uniqueness: true
    validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, presence: true, uniqueness:true

    #TODO: Custom Validation
    validate :must_have_perferred_email 
    
    def must_have_perferred_email
        unless email.match?(/gmail.com|yahoo.com|hotmail.com|outlook.com|aol.com/)
            errors.add(:email, "Sorry, we only allow specific email providers")
        end 
    end 
end
