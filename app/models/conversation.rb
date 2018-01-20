class Conversation < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  has_many :posts
end
