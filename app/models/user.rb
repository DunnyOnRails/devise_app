class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# DD - added so the client_side_validation gem can pick up the errors and display them in the form
    validates :username, :presence => true
    validates :username, :uniqueness => true
    validates :email, :presence => true
    validates_confirmation_of :password
    validates :agreed_terms, :acceptance => true

  has_one :profile
end
