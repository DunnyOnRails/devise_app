class Board < ApplicationRecord
    has_many :subjects
    extend FriendlyId
    friendly_id :name, use: :slugged
end
