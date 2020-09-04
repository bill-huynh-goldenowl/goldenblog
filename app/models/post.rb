class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, as: :commentable

  enum status: [:awaiting_approval, :approval, :disapproval]

  validates_length_of :title, uniqueness: true, minimum: 6, maximum: 30
  validates :content, length: {minimum: 30}, allow_blank: true
  validates :images, presence: true
end

