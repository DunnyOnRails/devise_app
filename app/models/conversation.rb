class Conversation < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  has_many :posts
  extend FriendlyId
  friendly_id :content, use: :slugged
end
