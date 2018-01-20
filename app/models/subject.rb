class Subject < ApplicationRecord
  belongs_to :board
  has_many :conversations
end
