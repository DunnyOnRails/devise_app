class Subject < ApplicationRecord
  belongs_to :board
  has_many :conversations

  validates :name, :presence => true,  :length => {:within => 6..70}
  validates :description, :presence => true
end
