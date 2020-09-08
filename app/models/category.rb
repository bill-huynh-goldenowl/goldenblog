class Category < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :title, presence: true, length: {minimum: 6}
  validates :description, length: {minimum: 30}
end