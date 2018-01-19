class Profile < ApplicationRecord
  belongs_to :user, :foreign_key => :username, :primary_key => :username
  # belongs_to :user
  has_attached_file :avatar, styles: { medium: "264x264#", thumb: "100x100>" }, default_url: "../../assets/team/temp_face.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # validates_format_of :handle, :with => /[^0-9a-z]/i
  validates_format_of :handle, :with => /\A\w+\z/
  # validate :handle_cannot_use_special_characters

  def handle_cannot_use_special_characters
    # errors.add(:handle, "field must only contain letters. Please try again.")
  end

end
