class Pin < ActiveRecord::Base
  belongs_to :user

  validates :image, presence: true
  validates :description, presence: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
