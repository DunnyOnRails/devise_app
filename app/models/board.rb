class Board < ApplicationRecord
    #has_many :subjects
    extend FriendlyId
    friendly_id :name, use: :slugged
    validates :name, :presence => true,  :length => {:within => 6..70}
    validates :description, :presence => true
        
end
