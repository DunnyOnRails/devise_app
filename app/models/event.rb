class Event < ApplicationRecord
    validates :date, :presence => true,  :length => {:within => 6..70}
    validates :title, :presence => true,  :length => {:within => 6..70}
    validates :content, :presence => true
end
