class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # DD - added so the client_side_validation gem can pick up the errors and display them in the form
    validates :username, :presence => true,  :length => {:within => 6..40}
    validates :username, :uniqueness => true
    validates :email, :presence => true
    validates_confirmation_of :password
    validates :agreed_terms, :acceptance => true


  # # using any of these validations below causes an error where it navigates to /users/sign in, possibly becasue of the same name twice?
    # validates :password, :presence => true
    # validates_presence_of     :password
    # validates :password, :presence => true,
    #   :confirmation => true,
    #   :length => {:within => 6..40}

  has_one :profile
end
